import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import '../models/ply_data.dart';

class PointCloudRenderer {
  List<Vector3> _positions = [];
  List<Color> _colors = [];
  int _vertexCount = 0;
  
  Matrix4 _viewMatrix = Matrix4.identity();
  Matrix4 _projectionMatrix = Matrix4.identity();
  
  double _cameraDistance = 5.0;
  double _cameraRotationX = 0.0;
  double _cameraRotationY = 0.0;
  
  Vector3 _boundingBoxMin = Vector3.zero();
  Vector3 _boundingBoxMax = Vector3.zero();
  Vector3 _boundingBoxCenter = Vector3.zero();
  
  Future<void> initialize() async {
    // In a Canvas-based renderer, initialization is minimal
    // This method is kept for API compatibility
  }
  
  void loadPointCloud(PlyData plyData) {
    _vertexCount = plyData.vertices.length;
    _positions.clear();
    _colors.clear();
    
    for (final vertex in plyData.vertices) {
      _positions.add(Vector3(
        vertex.x.toDouble(),
        vertex.y.toDouble(),
        vertex.z.toDouble(),
      ));
      
      if (vertex.red != null && vertex.green != null && vertex.blue != null) {
        _colors.add(Color.fromARGB(
          vertex.alpha ?? 255,
          vertex.red!,
          vertex.green!,
          vertex.blue!,
        ));
      } else {
        _colors.add(Colors.white);
      }
    }
    
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
      minX = math.min(minX, vertex.x);
      maxX = math.max(maxX, vertex.x);
      minY = math.min(minY, vertex.y);
      maxY = math.max(maxY, vertex.y);
      minZ = math.min(minZ, vertex.z);
      maxZ = math.max(maxZ, vertex.z);
    }
    
    _boundingBoxMin = Vector3(minX, minY, minZ);
    _boundingBoxMax = Vector3(maxX, maxY, maxZ);
    _boundingBoxCenter = (_boundingBoxMin + _boundingBoxMax) * 0.5;
    
    final size = _boundingBoxMax - _boundingBoxMin;
    final maxSize = math.max(math.max(size.x, size.y), size.z);
    
    _cameraDistance = maxSize * 2.0;
    
    _viewMatrix = Matrix4.identity()
      ..translate(-_boundingBoxCenter.x, -_boundingBoxCenter.y, -_boundingBoxCenter.z);
  }
  
  void updateCamera(double rotationX, double rotationY, double zoom) {
    _cameraRotationX = rotationX;
    _cameraRotationY = rotationY;
    _cameraDistance = zoom;
  }
  
  void render(Canvas canvas, Size size) {
    if (_positions.isEmpty) return;
    
    // Clear background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color.fromARGB(255, 26, 26, 38),
    );
    
    // Update matrices
    _updateMatrices(size);
    
    // Create combined view-projection matrix
    final cameraMatrix = Matrix4.identity()
      ..translate(0.0, 0.0, -_cameraDistance)
      ..rotateX(_cameraRotationX)
      ..rotateY(_cameraRotationY);
    
    final viewProjection = _projectionMatrix * cameraMatrix * _viewMatrix;
    
    // Project and sort points by depth
    final projectedPoints = <_ProjectedPoint>[];
    
    for (int i = 0; i < _positions.length; i++) {
      final worldPos = Vector4(
        _positions[i].x,
        _positions[i].y,
        _positions[i].z,
        1.0,
      );
      
      // Transform to clip space
      final clipPos = viewProjection.transformed(worldPos);
      
      // Skip points behind camera
      if (clipPos.w <= 0) continue;
      
      // Perspective divide
      final ndcX = clipPos.x / clipPos.w;
      final ndcY = clipPos.y / clipPos.w;
      final ndcZ = clipPos.z / clipPos.w;
      
      // Skip points outside NDC
      if (ndcX < -1 || ndcX > 1 || ndcY < -1 || ndcY > 1 || ndcZ < -1 || ndcZ > 1) {
        continue;
      }
      
      // Convert to screen coordinates
      final screenX = (ndcX + 1) * 0.5 * size.width;
      final screenY = (1 - ndcY) * 0.5 * size.height;
      
      projectedPoints.add(_ProjectedPoint(
        x: screenX,
        y: screenY,
        depth: clipPos.z,
        color: _colors[i],
        size: 3.0 / (clipPos.w * 0.5), // Adjust point size based on depth
      ));
    }
    
    // Sort by depth (painter's algorithm)
    projectedPoints.sort((a, b) => b.depth.compareTo(a.depth));
    
    // Draw points
    final paint = Paint()
      ..style = PaintingStyle.fill;
    
    for (final point in projectedPoints) {
      paint.color = point.color;
      canvas.drawCircle(
        Offset(point.x, point.y),
        point.size.clamp(0.5, 5.0),
        paint,
      );
    }
    
    // Draw info
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Points: $_vertexCount',
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(10, 10));
  }
  
  void _updateMatrices(Size size) {
    final aspectRatio = size.width / size.height;
    
    _projectionMatrix = makePerspectiveMatrix(
      radians(60.0),
      aspectRatio,
      0.1,
      1000.0,
    );
  }
  
  void dispose() {
    _positions.clear();
    _colors.clear();
  }
}

class _ProjectedPoint {
  final double x;
  final double y;
  final double depth;
  final Color color;
  final double size;
  
  _ProjectedPoint({
    required this.x,
    required this.y,
    required this.depth,
    required this.color,
    required this.size,
  });
}