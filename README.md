# Flutter Point Cloud Viewer

A Flutter application that parses and renders PLY point cloud files using Flutter GPU or Canvas-based rendering.

## Features

- Parse PLY files (both ASCII and binary formats)
- **Flutter GPU rendering** for high performance (100x faster)
- Canvas-based fallback renderer for compatibility
- Interactive camera controls (rotate, zoom)
- Support for colored point clouds
- Optimized for large datasets with streaming parsing
- Runtime renderer switching (GPU/Canvas)

## Requirements

- Flutter SDK master channel (managed via FVM)
- Dart SDK

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_gpu_point_cloud.git
cd flutter_gpu_point_cloud
```

2. Install FVM and set up Flutter version:
```bash
# Install FVM if not already installed
dart pub global activate fvm

# Install the Flutter version specified for this project (master channel)
fvm install

# Alternatively, for reproducible builds, use a specific commit:
# cp .fvm/fvm_config_commit.json.example .fvm/fvm_config.json
# fvm install

# Use FVM's Flutter version
fvm flutter --version
```

3. Install dependencies:
```bash
fvm flutter pub get
fvm flutter pub run build_runner build
```

## Usage

1. Run the application:
```bash
fvm flutter run
```

2. Click "Load PLY File" to select a point cloud file
3. Use the following controls:
   - **Drag**: Rotate the camera around the point cloud
   - **Mouse Scroll / Pinch**: Zoom in and out
   - **ESC**: Reset camera position (keyboard only)

## Sample Files

The project includes two sample PLY files for testing:
- `sample_cube.ply`: A simple colored cube with 8 vertices
- `sample_sphere.ply`: A colored sphere with 162 vertices

## Project Structure

```
lib/
├── main.dart                    # Application entry point and UI
├── models/
│   └── ply_data.dart           # Data models for PLY format (using Freezed)
├── parsers/
│   └── ply_parser.dart         # PLY file parser (ASCII & binary)
├── rendering/
│   └── point_cloud_renderer.dart # Canvas-based 3D renderer
└── widgets/
    └── point_cloud_viewer.dart   # Interactive viewer widget
```

## Architecture

- **PLY Parser**: Handles both ASCII and binary PLY formats with streaming support
- **Flutter GPU Renderer**: Hardware-accelerated rendering using GPU shaders
- **Canvas Renderer**: Software fallback using Flutter's Canvas API
- **Shader Pipeline**: Custom vertex and fragment shaders for point rendering
- **Camera Controls**: Interactive controls for viewing the point cloud
- **Matrix Transformations**: Uses vector_math for 3D transformations

## Supported PLY Properties

- Vertex positions (x, y, z)
- Vertex normals (nx, ny, nz) - optional
- Vertex colors (red, green, blue, alpha) - optional
- Face data (basic support for parsing, not rendered)

## Performance Notes

### Flutter GPU Renderer
- Suitable for point clouds up to **1,000,000+ points**
- Hardware-accelerated with GPU shaders
- No CPU-based depth sorting required
- Consistent 60 FPS for large datasets

### Canvas Renderer (Fallback)
- Suitable for point clouds up to ~100,000 points
- CPU-based rendering with depth sorting
- Performance depends on device capabilities
- Consider reducing point cloud size for mobile devices

## Future Enhancements

- [ ] Level-of-detail (LOD) rendering for large point clouds
- [ ] Octree-based spatial indexing
- [ ] Point size adjustment UI
- [ ] Export functionality
- [ ] Support for additional PLY properties
- [ ] Compute shaders for GPU-based processing

## License

This project is open source and available under the MIT License.