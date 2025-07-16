import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'models/ply_data.dart';
import 'parsers/ply_parser.dart';
import 'widgets/point_cloud_viewer.dart';
import 'widgets/gpu_point_cloud_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GPU Point Cloud Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PointCloudViewerPage(),
    );
  }
}

class PointCloudViewerPage extends StatefulWidget {
  const PointCloudViewerPage({super.key});

  @override
  State<PointCloudViewerPage> createState() => _PointCloudViewerPageState();
}

class _PointCloudViewerPageState extends State<PointCloudViewerPage> {
  PlyData? _plyData;
  bool _isLoading = false;
  String? _fileName;
  String? _errorMessage;
  int? _pointCount;
  bool _useGpuRenderer = true;

  Future<void> _pickAndLoadFile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        /*type: FileType.custom,
        allowedExtensions: ['ply'],*/
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        final bytes = file.bytes!;
        
        final plyData = await PlyParser.parseFile(bytes);
        
        setState(() {
          _plyData = plyData;
          _fileName = file.name;
          _pointCount = plyData.vertices.length;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter GPU Point Cloud Viewer'),
        actions: [
          if (_fileName != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '$_fileName (${_pointCount ?? 0} points)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          _useGpuRenderer
              ? GpuPointCloudViewer(plyData: _plyData)
              : PointCloudViewer(plyData: _plyData),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_errorMessage != null)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Controls:', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('• Drag: Rotate camera'),
                        Text('• Scroll/Pinch: Zoom'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Renderer: '),
                        ChoiceChip(
                          label: const Text('GPU'),
                          selected: _useGpuRenderer,
                          onSelected: (selected) {
                            setState(() {
                              _useGpuRenderer = true;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Canvas'),
                          selected: !_useGpuRenderer,
                          onSelected: (selected) {
                            setState(() {
                              _useGpuRenderer = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.extended(
                  onPressed: _isLoading ? null : _pickAndLoadFile,
                  label: const Text('Load PLY File'),
                  icon: const Icon(Icons.folder_open),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}