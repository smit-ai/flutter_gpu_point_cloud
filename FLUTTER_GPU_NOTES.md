# Flutter GPU Implementation Notes

This is an experimental implementation using Flutter GPU, which is still in early development.

## Current Status

The Flutter GPU API is highly experimental and subject to change. This implementation:

1. **Uses inline shaders** - Direct GLSL code in Dart strings
2. **Manual buffer management** - Direct vertex buffer creation
3. **Raw GPU API calls** - No high-level abstractions yet

## Known Issues

- API changes frequently between Flutter versions
- Documentation is minimal
- Some features may not work on all platforms

## Running with GPU

```bash
# Enable Impeller (required for Flutter GPU)
flutter run --enable-impeller

# For better debugging
flutter run --enable-impeller --verbose
```

## API Usage Examples

### Creating Shaders
```dart
final library = _gpuContext!.createShaderLibrary(shaderSource);
final shader = library!['main'];
```

### Creating Buffers
```dart
// Device buffer (GPU memory)
final buffer = _gpuContext!.createDeviceBufferWithCopy(data);

// Host buffer (CPU memory, accessible from GPU)
final buffer = _gpuContext!.createDeviceBuffer(
  gpu.StorageMode.hostVisible,
  sizeInBytes,
);
```

### Render Pipeline
```dart
final pipeline = _gpuContext!.createRenderPipeline(vertexShader, fragmentShader);
```

## Experimental Features Used

1. **Point Rendering** - Using `gl_PointSize` in vertex shader
2. **Texture Rendering** - Rendering to texture then displaying as image
3. **Manual Matrix Math** - CPU-side matrix calculations

## Future Improvements

When Flutter GPU stabilizes:
- Geometry shaders for better point rendering
- Compute shaders for GPU-based culling
- Instanced rendering for repeated geometry
- Multiple render passes for effects

## References

- [Flutter GPU Proposal](https://github.com/flutter/flutter/issues/new)
- [Impeller Documentation](https://github.com/flutter/engine/tree/main/impeller)
- [Flutter GPU Examples](https://github.com/flutter/engine/tree/main/examples/flutter_gpu_test)