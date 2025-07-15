# Flutter Point Cloud Viewer

A Flutter application that parses and renders PLY point cloud files using Canvas-based rendering.

## Features

- Parse PLY files (both ASCII and binary formats)
- Render point clouds using Canvas-based 3D projection
- Interactive camera controls (rotate, zoom)
- Support for colored point clouds
- Optimized for large datasets with streaming parsing

## Requirements

- Flutter SDK 3.7.0 or higher
- Dart SDK

## Setup

1. Install dependencies:
```bash
flutter pub get
flutter pub run build_runner build
```

## Usage

1. Run the application:
```bash
flutter run
```

2. Click "Load PLY File" to select a point cloud file
3. Use the following controls:
   - Drag to rotate the camera
   - Scroll or pinch to zoom

## Architecture

- **PLY Parser**: Handles both ASCII and binary PLY formats with streaming support
- **Canvas Renderer**: 3D projection and rendering using Flutter's Canvas API
- **Depth Sorting**: Painter's algorithm for proper point occlusion
- **Camera Controls**: Interactive controls for viewing the point cloud

## Supported PLY Properties

- Vertex positions (x, y, z)
- Vertex normals (nx, ny, nz) - optional
- Vertex colors (red, green, blue, alpha) - optional
- Face data (basic support)

## Notes

This application demonstrates point cloud rendering using Flutter's Canvas API with 3D projection mathematics. For large point clouds, performance may vary depending on the device.