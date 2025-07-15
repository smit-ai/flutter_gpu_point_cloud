import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gpu/gpu.dart' as gpu;
import '../models/ply_data.dart';
import '../rendering/flutter_gpu_renderer.dart';

class GpuPointCloudViewer extends StatefulWidget {
  final PlyData? plyData;
  
  const GpuPointCloudViewer({
    Key? key,
    this.plyData,
  }) : super(key: key);
  
  @override
  State<GpuPointCloudViewer> createState() => _GpuPointCloudViewerState();
}

class _GpuPointCloudViewerState extends State<GpuPointCloudViewer> {
  final FlutterGpuPointCloudRenderer _renderer = FlutterGpuPointCloudRenderer();
  
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _zoom = 5.0;
  
  Offset? _lastFocalPoint;
  double? _lastScale;
  
  bool _isInitialized = false;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _initializeRenderer();
  }
  
  Future<void> _initializeRenderer() async {
    try {
      await _renderer.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }
  
  @override
  void didUpdateWidget(GpuPointCloudViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.plyData != oldWidget.plyData && widget.plyData != null) {
      _renderer.loadPointCloud(widget.plyData!);
    }
  }
  
  @override
  void dispose() {
    _renderer.dispose();
    super.dispose();
  }
  
  void _handleScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.focalPoint;
    _lastScale = 1.0;
  }
  
  void _handleScaleUpdate(ScaleUpdateDetails details) {
    // Handle rotation (pan)
    if (_lastFocalPoint != null && details.scale == 1.0) {
      final delta = details.focalPoint - _lastFocalPoint!;
      setState(() {
        _rotationY += delta.dx * 0.01;
        _rotationX += delta.dy * 0.01;
        _rotationX = _rotationX.clamp(-1.57, 1.57); // Limit to +/- 90 degrees
      });
      _lastFocalPoint = details.focalPoint;
      _renderer.updateCamera(_rotationX, _rotationY, _zoom);
    }
    
    // Handle zoom (scale)
    if (_lastScale != null && details.scale != 1.0) {
      final scaleDelta = details.scale / _lastScale!;
      setState(() {
        _zoom = (_zoom / scaleDelta).clamp(0.5, 50.0);
      });
      _lastScale = details.scale;
      _renderer.updateCamera(_rotationX, _rotationY, _zoom);
    }
  }
  
  void _handleScaleEnd(ScaleEndDetails details) {
    _lastFocalPoint = null;
    _lastScale = null;
  }
  
  void _handleMouseScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        final delta = event.scrollDelta.dy > 0 ? 1.1 : 0.9;
        _zoom = (_zoom * delta).clamp(0.5, 50.0);
      });
      _renderer.updateCamera(_rotationX, _rotationY, _zoom);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error initializing GPU renderer:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (widget.plyData == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No point cloud loaded'),
            SizedBox(height: 8),
            Text('Select a PLY file to view'),
          ],
        ),
      );
    }
    
    return Listener(
      onPointerSignal: _handleMouseScroll,
      child: GestureDetector(
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleUpdate,
        onScaleEnd: _handleScaleEnd,
        child: Container(
          color: Colors.black12,
          child: CustomPaint(
            painter: _GpuPointCloudPainter(_renderer),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class _GpuPointCloudPainter extends CustomPainter {
  final FlutterGpuPointCloudRenderer renderer;
  
  _GpuPointCloudPainter(this.renderer);
  
  @override
  void paint(Canvas canvas, Size size) {
    renderer.render(canvas, size);
  }
  
  @override
  bool shouldRepaint(_GpuPointCloudPainter oldDelegate) => true;
}