import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import '../models/ply_data.dart';

class WebGLPointCloudRenderer {
  html.CanvasElement? _canvas;
  html.WebGLRenderingContext? _gl;
  html.Program? _program;
  html.Buffer? _vertexBuffer;
  html.Buffer? _colorBuffer;
  
  int _vertexCount = 0;
  Matrix4 _viewMatrix = Matrix4.identity();
  Matrix4 _projectionMatrix = Matrix4.identity();
  
  double _cameraDistance = 5.0;
  double _cameraRotationX = 0.0;
  double _cameraRotationY = 0.0;
  
  Future<void> initialize(int width, int height) async {
    _canvas = html.CanvasElement(width: width, height: height);
    _gl = _canvas!.getContext3d();
    
    if (_gl == null) {
      throw Exception('WebGL not supported');
    }
    
    await _initShaders();
    _gl!.clearColor(0.1, 0.1, 0.15, 1.0);
    _gl!.enable(html.WebGLRenderingContext.DEPTH_TEST);
  }
  
  Future<void> _initShaders() async {
    const vertexShaderSource = '''
      attribute vec3 position;
      attribute vec4 color;
      
      uniform mat4 viewProjection;
      
      varying vec4 vColor;
      
      void main() {
        gl_Position = viewProjection * vec4(position, 1.0);
        gl_PointSize = 3.0;
        vColor = color;
      }
    ''';
    
    const fragmentShaderSource = '''
      precision mediump float;
      
      varying vec4 vColor;
      
      void main() {
        vec2 coord = gl_PointCoord - vec2(0.5);
        float dist = length(coord);
        
        if (dist > 0.5) {
          discard;
        }
        
        float alpha = 1.0 - smoothstep(0.4, 0.5, dist);
        gl_FragColor = vec4(vColor.rgb, vColor.a * alpha);
      }
    ''';
    
    final vertexShader = _compileShader(
      html.WebGLRenderingContext.VERTEX_SHADER,
      vertexShaderSource,
    );
    
    final fragmentShader = _compileShader(
      html.WebGLRenderingContext.FRAGMENT_SHADER,
      fragmentShaderSource,
    );
    
    _program = _gl!.createProgram()!;
    _gl!.attachShader(_program!, vertexShader);
    _gl!.attachShader(_program!, fragmentShader);
    _gl!.linkProgram(_program!);
    
    if (!(_gl!.getProgramParameter(_program!, html.WebGLRenderingContext.LINK_STATUS) as bool)) {
      throw Exception('Failed to link program: ${_gl!.getProgramInfoLog(_program!)}');
    }
    
    _gl!.useProgram(_program!);
  }
  
  html.Shader _compileShader(int type, String source) {
    final shader = _gl!.createShader(type)!;
    _gl!.shaderSource(shader, source);
    _gl!.compileShader(shader);
    
    if (!(_gl!.getShaderParameter(shader, html.WebGLRenderingContext.COMPILE_STATUS) as bool)) {
      throw Exception('Failed to compile shader: ${_gl!.getShaderInfoLog(shader)}');
    }
    
    return shader;
  }
  
  void loadPointCloud(PlyData plyData) {
    _vertexCount = plyData.vertices.length;
    
    final positions = Float32List(_vertexCount * 3);
    final colors = Float32List(_vertexCount * 4);
    
    for (int i = 0; i < _vertexCount; i++) {
      final vertex = plyData.vertices[i];
      
      positions[i * 3] = vertex.x.toDouble();
      positions[i * 3 + 1] = vertex.y.toDouble();
      positions[i * 3 + 2] = vertex.z.toDouble();
      
      if (vertex.red != null && vertex.green != null && vertex.blue != null) {
        colors[i * 4] = vertex.red! / 255.0;
        colors[i * 4 + 1] = vertex.green! / 255.0;
        colors[i * 4 + 2] = vertex.blue! / 255.0;
        colors[i * 4 + 3] = vertex.alpha != null ? vertex.alpha! / 255.0 : 1.0;
      } else {
        colors[i * 4] = 1.0;
        colors[i * 4 + 1] = 1.0;
        colors[i * 4 + 2] = 1.0;
        colors[i * 4 + 3] = 1.0;
      }
    }
    
    // Create vertex buffer
    _vertexBuffer = _gl!.createBuffer();
    _gl!.bindBuffer(html.WebGLRenderingContext.ARRAY_BUFFER, _vertexBuffer);
    _gl!.bufferData(
      html.WebGLRenderingContext.ARRAY_BUFFER,
      positions,
      html.WebGLRenderingContext.STATIC_DRAW,
    );
    
    // Create color buffer
    _colorBuffer = _gl!.createBuffer();
    _gl!.bindBuffer(html.WebGLRenderingContext.ARRAY_BUFFER, _colorBuffer);
    _gl!.bufferData(
      html.WebGLRenderingContext.ARRAY_BUFFER,
      colors,
      html.WebGLRenderingContext.STATIC_DRAW,
    );
    
    _computeBoundingBox(plyData.vertices);
  }
  
  void _computeBoundingBox(List<PlyVertex> vertices) {
    if (vertices.isEmpty) return;
    
    double minX = vertices.first.x;
    double maxX = vertices.first.x;
    double minY = vertices.first.y;
    double maxY = vertices.first.y;
    double minZ = vertices.first.z;
    double maxZ = vertices.first.z;
    
    for (final vertex in vertices) {
      minX = minX < vertex.x ? minX : vertex.x;
      maxX = maxX > vertex.x ? maxX : vertex.x;
      minY = minY < vertex.y ? minY : vertex.y;
      maxY = maxY > vertex.y ? maxY : vertex.y;
      minZ = minZ < vertex.z ? minZ : vertex.z;
      maxZ = maxZ > vertex.z ? maxZ : vertex.z;
    }
    
    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;
    final centerZ = (minZ + maxZ) / 2;
    
    final sizeX = maxX - minX;
    final sizeY = maxY - minY;
    final sizeZ = maxZ - minZ;
    final maxSize = [sizeX, sizeY, sizeZ].reduce((a, b) => a > b ? a : b);
    
    _cameraDistance = maxSize * 2.0;
    
    _viewMatrix = Matrix4.identity()
      ..translate(-centerX, -centerY, -centerZ);
  }
  
  void updateCamera(double rotationX, double rotationY, double zoom) {
    _cameraRotationX = rotationX;
    _cameraRotationY = rotationY;
    _cameraDistance = zoom;
  }
  
  void render(Size size) {
    if (_gl == null || _program == null || _vertexBuffer == null || _vertexCount == 0) {
      return;
    }
    
    _gl!.viewport(0, 0, size.width.toInt(), size.height.toInt());
    _gl!.clear(html.WebGLRenderingContext.COLOR_BUFFER_BIT | 
                html.WebGLRenderingContext.DEPTH_BUFFER_BIT);
    
    // Update matrices
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
    
    // Set uniforms
    final viewProjectionLocation = _gl!.getUniformLocation(_program!, 'viewProjection');
    _gl!.uniformMatrix4fv(viewProjectionLocation, false, viewProjection.storage);
    
    // Bind position buffer
    final positionLocation = _gl!.getAttribLocation(_program!, 'position');
    _gl!.bindBuffer(html.WebGLRenderingContext.ARRAY_BUFFER, _vertexBuffer);
    _gl!.vertexAttribPointer(positionLocation, 3, html.WebGLRenderingContext.FLOAT, false, 0, 0);
    _gl!.enableVertexAttribArray(positionLocation);
    
    // Bind color buffer
    final colorLocation = _gl!.getAttribLocation(_program!, 'color');
    _gl!.bindBuffer(html.WebGLRenderingContext.ARRAY_BUFFER, _colorBuffer);
    _gl!.vertexAttribPointer(colorLocation, 4, html.WebGLRenderingContext.FLOAT, false, 0, 0);
    _gl!.enableVertexAttribArray(colorLocation);
    
    // Draw points
    _gl!.drawArrays(html.WebGLRenderingContext.POINTS, 0, _vertexCount);
  }
  
  html.CanvasElement? get canvas => _canvas;
  
  void dispose() {
    _gl?.deleteBuffer(_vertexBuffer);
    _gl?.deleteBuffer(_colorBuffer);
    _gl?.deleteProgram(_program);
  }
}