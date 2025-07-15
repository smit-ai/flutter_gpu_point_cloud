import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_gpu/gpu.dart' as gpu;
import 'package:vector_math/vector_math_64.dart' hide Colors;
import '../models/ply_data.dart';

class FlutterGpuPointCloudRenderer {
  gpu.GpuContext? _gpuContext;
  gpu.RenderPipeline? _pipeline;
  gpu.DeviceBuffer? _vertexBuffer;
  gpu.DeviceBuffer? _uniformBuffer;
  gpu.Shader? _vertexShader;
  gpu.Shader? _fragmentShader;
  
  int _vertexCount = 0;
  
  Matrix4 _viewMatrix = Matrix4.identity();
  Matrix4 _projectionMatrix = Matrix4.identity();
  
  double _cameraDistance = 5.0;
  double _cameraRotationX = 0.0;
  double _cameraRotationY = 0.0;
  
  Vector3 _boundingBoxCenter = Vector3.zero();
  
  Future<void> initialize() async {
    _gpuContext = gpu.gpuContext;
    
    if (_gpuContext == null) {
      throw Exception('GPU context not available. Make sure to run with --enable-impeller flag.');
    }
    
    await _loadShaders();
    await _createPipeline();
    await _createUniformBuffer();
  }
  
  Future<void> _loadShaders() async {
    // Inline shader source for experimental purposes
    const vertexShaderSource = '''
#version 320 es

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;

layout(binding = 0) uniform UniformBuffer {
    mat4 viewProjection;
} uniforms;

out vec4 fragColor;

void main() {
    gl_Position = uniforms.viewProjection * vec4(position, 1.0);
    gl_PointSize = 3.0;
    fragColor = color;
}
''';

    const fragmentShaderSource = '''
#version 320 es
precision mediump float;

in vec4 fragColor;
out vec4 outColor;

void main() {
    vec2 coord = gl_PointCoord - vec2(0.5);
    float dist = length(coord);
    
    if (dist > 0.5) {
        discard;
    }
    
    float alpha = 1.0 - smoothstep(0.4, 0.5, dist);
    outColor = vec4(fragColor.rgb, fragColor.a * alpha);
}
''';

    // Create shader library from source
    final vertexLibrary = _gpuContext!.createShaderLibrary(vertexShaderSource);
    final fragmentLibrary = _gpuContext!.createShaderLibrary(fragmentShaderSource);
    
    _vertexShader = vertexLibrary!['main'];
    _fragmentShader = fragmentLibrary!['main'];
    
    if (_vertexShader == null || _fragmentShader == null) {
      throw Exception('Failed to load shaders');
    }
  }
  
  Future<void> _createPipeline() async {
    _pipeline = _gpuContext!.createRenderPipeline(_vertexShader!, _fragmentShader!);
  }
  
  Future<void> _createUniformBuffer() async {
    // Create uniform buffer for view-projection matrix
    final uniformData = Float32List(16); // 1 4x4 matrix
    _uniformBuffer = _gpuContext!.createDeviceBuffer(
      gpu.StorageMode.hostVisible,
      uniformData.lengthInBytes,
    );
  }
  
  void loadPointCloud(PlyData plyData) {
    _vertexCount = plyData.vertices.length;
    
    // Vertex layout: position (3 floats) + color (4 floats) = 7 floats per vertex
    final vertexData = Float32List(_vertexCount * 7);
    
    double minX = double.infinity, maxX = -double.infinity;
    double minY = double.infinity, maxY = -double.infinity;
    double minZ = double.infinity, maxZ = -double.infinity;
    
    for (int i = 0; i < _vertexCount; i++) {
      final vertex = plyData.vertices[i];
      final baseIndex = i * 7;
      
      // Position
      vertexData[baseIndex] = vertex.x.toDouble();
      vertexData[baseIndex + 1] = vertex.y.toDouble();
      vertexData[baseIndex + 2] = vertex.z.toDouble();
      
      // Update bounding box
      minX = minX < vertex.x ? minX : vertex.x;
      maxX = maxX > vertex.x ? maxX : vertex.x;
      minY = minY < vertex.y ? minY : vertex.y;
      maxY = maxY > vertex.y ? maxY : vertex.y;
      minZ = minZ < vertex.z ? minZ : vertex.z;
      maxZ = maxZ > vertex.z ? maxZ : vertex.z;
      
      // Color
      if (vertex.red != null && vertex.green != null && vertex.blue != null) {
        vertexData[baseIndex + 3] = vertex.red! / 255.0;
        vertexData[baseIndex + 4] = vertex.green! / 255.0;
        vertexData[baseIndex + 5] = vertex.blue! / 255.0;
        vertexData[baseIndex + 6] = vertex.alpha != null ? vertex.alpha! / 255.0 : 1.0;
      } else {
        vertexData[baseIndex + 3] = 1.0;
        vertexData[baseIndex + 4] = 1.0;
        vertexData[baseIndex + 5] = 1.0;
        vertexData[baseIndex + 6] = 1.0;
      }
    }
    
    // Compute bounding box center
    _boundingBoxCenter = Vector3(
      (minX + maxX) / 2,
      (minY + maxY) / 2,
      (minZ + maxZ) / 2,
    );
    
    final sizeX = maxX - minX;
    final sizeY = maxY - minY;
    final sizeZ = maxZ - minZ;
    final maxSize = [sizeX, sizeY, sizeZ].reduce((a, b) => a > b ? a : b);
    
    _cameraDistance = maxSize * 2.0;
    
    // Create vertex buffer
    _vertexBuffer = _gpuContext!.createDeviceBufferWithCopy(
      ByteData.view(vertexData.buffer),
    );
    
    _viewMatrix = Matrix4.identity()
      ..translate(-_boundingBoxCenter.x, -_boundingBoxCenter.y, -_boundingBoxCenter.z);
  }
  
  void updateCamera(double rotationX, double rotationY, double zoom) {
    _cameraRotationX = rotationX;
    _cameraRotationY = rotationY;
    _cameraDistance = zoom;
  }
  
  void render(Canvas canvas, Size size) {
    if (_gpuContext == null || _pipeline == null || _vertexBuffer == null || _vertexCount == 0) {
      return;
    }
    
    // Create render texture
    final texture = _gpuContext!.createTexture(
      gpu.StorageMode.devicePrivate,
      size.width.toInt(),
      size.height.toInt(),
    );
    
    if (texture == null) return;
    
    // Update matrices
    _updateMatrices(size);
    
    // Create command buffer
    final commandBuffer = _gpuContext!.createCommandBuffer();
    
    // Create color attachment
    final colorAttachment = gpu.ColorAttachment(
      texture: texture,
      loadAction: gpu.LoadAction.clear,
      storeAction: gpu.StoreAction.store,
    );
    colorAttachment.clearValue = Vector4(0.1, 0.1, 0.15, 1.0);
    
    // Create render target
    final renderTarget = gpu.RenderTarget.singleColor(colorAttachment);
    
    // Create render pass
    final renderPass = commandBuffer.createRenderPass(renderTarget);
    
    // Bind pipeline
    renderPass.bindPipeline(_pipeline!);
    
    // Bind vertex buffer
    renderPass.bindVertexBuffer(
      gpu.BufferView(
        _vertexBuffer!,
        offsetInBytes: 0,
        lengthInBytes: _vertexBuffer!.sizeInBytes,
      ),
      0,
    );
    
    // Bind uniform buffer  
    renderPass.bindVertexBuffer(
      gpu.BufferView(
        _uniformBuffer!,
        offsetInBytes: 0,
        lengthInBytes: _uniformBuffer!.sizeInBytes,
      ),
      1,
    );
    
    // Draw points
    renderPass.draw();
    
    // Submit command buffer
    commandBuffer.submit();
    
    // Draw texture to canvas
    final image = texture.asImage();
    canvas.drawImage(image, Offset.zero, Paint());
  }
  
  void _updateMatrices(Size size) {
    final aspectRatio = size.width / size.height;
    
    _projectionMatrix = makePerspectiveMatrix(
      radians(60.0),
      aspectRatio,
      0.1,
      1000.0,
    );
    
    final cameraMatrix = Matrix4.identity()
      ..translate(0.0, 0.0, -_cameraDistance)
      ..rotateX(_cameraRotationX)
      ..rotateY(_cameraRotationY);
    
    final viewProjection = _projectionMatrix * cameraMatrix * _viewMatrix;
    
    // Update uniform buffer with view-projection matrix
    final uniformData = Float32List(16);
    for (int i = 0; i < 16; i++) {
      uniformData[i] = viewProjection[i];
    }
    
    _uniformBuffer!.overwrite(ByteData.view(uniformData.buffer));
  }
  
  void dispose() {
    // Resources will be garbage collected
  }
}