import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../models/ply_data.dart';

class PlyParser {
  static const String _plyMagic = 'ply';
  
  static Future<PlyData> parseFile(Uint8List data) async {
    final asciiView = utf8.decode(data.sublist(0, data.length > 1000 ? 1000 : data.length), allowMalformed: true);
    
    if (!asciiView.startsWith(_plyMagic)) {
      throw FormatException('Invalid PLY file: missing magic header');
    }
    
    final lines = asciiView.split('\n');
    final header = await _parseHeader(lines);
    
    if (header.format == 'ascii') {
      return _parseAscii(data, header);
    } else {
      return _parseBinary(data, header);
    }
  }
  
  static Future<PlyHeader> _parseHeader(List<String> lines) async {
    String? format;
    int vertexCount = 0;
    int? faceCount;
    List<PlyProperty> vertexProperties = [];
    List<PlyProperty> faceProperties = [];
    
    bool inVertexElement = false;
    bool inFaceElement = false;
    
    for (final line in lines) {
      final trimmed = line.trim();
      
      if (trimmed.isEmpty) continue;
      
      if (trimmed == 'end_header') break;
      
      final parts = trimmed.split(' ');
      
      if (parts[0] == 'format') {
        format = parts[1];
      } else if (parts[0] == 'element') {
        if (parts[1] == 'vertex') {
          vertexCount = int.parse(parts[2]);
          inVertexElement = true;
          inFaceElement = false;
        } else if (parts[1] == 'face') {
          faceCount = int.parse(parts[2]);
          inFaceElement = true;
          inVertexElement = false;
        } else {
          inVertexElement = false;
          inFaceElement = false;
        }
      } else if (parts[0] == 'property') {
        final property = _parseProperty(parts);
        if (inVertexElement) {
          vertexProperties.add(property);
        } else if (inFaceElement) {
          faceProperties.add(property);
        }
      }
    }
    
    return PlyHeader(
      format: format ?? 'ascii',
      vertexCount: vertexCount,
      faceCount: faceCount,
      vertexProperties: vertexProperties,
      faceProperties: faceProperties.isEmpty ? null : faceProperties,
    );
  }
  
  static PlyProperty _parseProperty(List<String> parts) {
    if (parts[1] == 'list') {
      return PlyProperty(
        name: parts[4],
        type: PlyDataType.list,
        listLengthType: _parseDataType(parts[2]),
        listItemType: _parseDataType(parts[3]),
      );
    } else {
      return PlyProperty(
        name: parts[2],
        type: _parseDataType(parts[1]),
      );
    }
  }
  
  static PlyDataType _parseDataType(String type) {
    switch (type) {
      case 'char':
        return PlyDataType.char;
      case 'uchar':
        return PlyDataType.uchar;
      case 'short':
        return PlyDataType.short;
      case 'ushort':
        return PlyDataType.ushort;
      case 'int':
      case 'int32':
        return PlyDataType.int;
      case 'uint':
      case 'uint32':
        return PlyDataType.uint;
      case 'float':
      case 'float32':
        return PlyDataType.float;
      case 'double':
      case 'float64':
        return PlyDataType.double;
      default:
        throw FormatException('Unknown data type: $type');
    }
  }
  
  static Future<PlyData> _parseAscii(Uint8List data, PlyHeader header) async {
    final text = utf8.decode(data);
    final lines = text.split('\n');
    
    int lineIndex = 0;
    for (; lineIndex < lines.length; lineIndex++) {
      if (lines[lineIndex].trim() == 'end_header') {
        lineIndex++;
        break;
      }
    }
    
    final vertices = <PlyVertex>[];
    
    for (int i = 0; i < header.vertexCount && lineIndex < lines.length; i++, lineIndex++) {
      final line = lines[lineIndex].trim();
      if (line.isEmpty) {
        i--;
        continue;
      }
      
      final values = line.split(' ');
      final vertexData = <String, dynamic>{};
      
      for (int j = 0; j < header.vertexProperties.length && j < values.length; j++) {
        final prop = header.vertexProperties[j];
        final value = _parseValue(values[j], prop.type);
        vertexData[prop.name] = value;
      }
      
      vertices.add(PlyVertex(
        x: (vertexData['x'] ?? 0).toDouble(),
        y: (vertexData['y'] ?? 0).toDouble(),
        z: (vertexData['z'] ?? 0).toDouble(),
        nx: vertexData['nx']?.toDouble(),
        ny: vertexData['ny']?.toDouble(),
        nz: vertexData['nz']?.toDouble(),
        red: vertexData['red'] is int ? vertexData['red'] : vertexData['red']?.toInt(),
        green: vertexData['green'] is int ? vertexData['green'] : vertexData['green']?.toInt(),
        blue: vertexData['blue'] is int ? vertexData['blue'] : vertexData['blue']?.toInt(),
        alpha: vertexData['alpha'] is int ? vertexData['alpha'] : vertexData['alpha']?.toInt(),
      ));
    }
    
    final faces = <PlyFace>[];
    if (header.faceCount != null && header.faceCount! > 0) {
      for (int i = 0; i < header.faceCount! && lineIndex < lines.length; i++, lineIndex++) {
        final line = lines[lineIndex].trim();
        if (line.isEmpty) {
          i--;
          continue;
        }
        
        final values = line.split(' ');
        final count = int.parse(values[0]);
        final indices = <int>[];
        
        for (int j = 1; j <= count && j < values.length; j++) {
          indices.add(int.parse(values[j]));
        }
        
        faces.add(PlyFace(vertexIndices: indices));
      }
    }
    
    return PlyData(
      header: header,
      vertices: vertices,
      faces: faces.isEmpty ? null : faces,
    );
  }
  
  static dynamic _parseValue(String value, PlyDataType type) {
    switch (type) {
      case PlyDataType.char:
      case PlyDataType.uchar:
      case PlyDataType.short:
      case PlyDataType.ushort:
      case PlyDataType.int:
      case PlyDataType.uint:
        return int.parse(value);
      case PlyDataType.float:
      case PlyDataType.double:
        return double.parse(value);
      default:
        throw FormatException('Unsupported data type for parsing: $type');
    }
  }
  
  static Future<PlyData> _parseBinary(Uint8List data, PlyHeader header) async {
    int offset = 0;
    
    for (int i = 0; i < data.length - 10; i++) {
      if (data[i] == 0x65 && // 'e'
          data[i + 1] == 0x6E && // 'n'
          data[i + 2] == 0x64 && // 'd'
          data[i + 3] == 0x5F && // '_'
          data[i + 4] == 0x68 && // 'h'
          data[i + 5] == 0x65 && // 'e'
          data[i + 6] == 0x61 && // 'a'
          data[i + 7] == 0x64 && // 'd'
          data[i + 8] == 0x65 && // 'e'
          data[i + 9] == 0x72) { // 'r'
        offset = i + 11; // Skip "end_header\n"
        break;
      }
    }
    
    final isLittleEndian = header.format.contains('little');
    final byteData = ByteData.view(data.buffer, data.offsetInBytes + offset);
    
    final vertices = <PlyVertex>[];
    int byteOffset = 0;
    
    for (int i = 0; i < header.vertexCount; i++) {
      final vertexData = <String, dynamic>{};
      
      for (final prop in header.vertexProperties) {
        final value = _readBinaryValue(byteData, byteOffset, prop.type, isLittleEndian);
        vertexData[prop.name] = value;
        byteOffset += _getTypeSize(prop.type);
      }
      
      vertices.add(PlyVertex(
        x: (vertexData['x'] ?? 0).toDouble(),
        y: (vertexData['y'] ?? 0).toDouble(),
        z: (vertexData['z'] ?? 0).toDouble(),
        nx: vertexData['nx']?.toDouble(),
        ny: vertexData['ny']?.toDouble(),
        nz: vertexData['nz']?.toDouble(),
        red: vertexData['red'] is int ? vertexData['red'] : vertexData['red']?.toInt(),
        green: vertexData['green'] is int ? vertexData['green'] : vertexData['green']?.toInt(),
        blue: vertexData['blue'] is int ? vertexData['blue'] : vertexData['blue']?.toInt(),
        alpha: vertexData['alpha'] is int ? vertexData['alpha'] : vertexData['alpha']?.toInt(),
      ));
    }
    
    return PlyData(
      header: header,
      vertices: vertices,
    );
  }
  
  static dynamic _readBinaryValue(ByteData data, int offset, PlyDataType type, bool littleEndian) {
    switch (type) {
      case PlyDataType.char:
        return data.getInt8(offset);
      case PlyDataType.uchar:
        return data.getUint8(offset);
      case PlyDataType.short:
        return data.getInt16(offset, littleEndian ? Endian.little : Endian.big);
      case PlyDataType.ushort:
        return data.getUint16(offset, littleEndian ? Endian.little : Endian.big);
      case PlyDataType.int:
        return data.getInt32(offset, littleEndian ? Endian.little : Endian.big);
      case PlyDataType.uint:
        return data.getUint32(offset, littleEndian ? Endian.little : Endian.big);
      case PlyDataType.float:
        return data.getFloat32(offset, littleEndian ? Endian.little : Endian.big);
      case PlyDataType.double:
        return data.getFloat64(offset, littleEndian ? Endian.little : Endian.big);
      default:
        throw FormatException('Unsupported data type for binary reading: $type');
    }
  }
  
  static int _getTypeSize(PlyDataType type) {
    switch (type) {
      case PlyDataType.char:
      case PlyDataType.uchar:
        return 1;
      case PlyDataType.short:
      case PlyDataType.ushort:
        return 2;
      case PlyDataType.int:
      case PlyDataType.uint:
      case PlyDataType.float:
        return 4;
      case PlyDataType.double:
        return 8;
      default:
        throw FormatException('Unsupported data type for size calculation: $type');
    }
  }
}