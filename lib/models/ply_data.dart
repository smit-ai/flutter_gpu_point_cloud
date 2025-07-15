import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ply_data.freezed.dart';
part 'ply_data.g.dart';

@freezed
class PlyData with _$PlyData {
  const factory PlyData({
    required PlyHeader header,
    required List<PlyVertex> vertices,
    List<PlyFace>? faces,
  }) = _PlyData;

  factory PlyData.fromJson(Map<String, dynamic> json) => _$PlyDataFromJson(json);
}

@freezed
class PlyHeader with _$PlyHeader {
  const factory PlyHeader({
    required String format,
    required int vertexCount,
    int? faceCount,
    required List<PlyProperty> vertexProperties,
    List<PlyProperty>? faceProperties,
  }) = _PlyHeader;

  factory PlyHeader.fromJson(Map<String, dynamic> json) => _$PlyHeaderFromJson(json);
}

@freezed
class PlyProperty with _$PlyProperty {
  const factory PlyProperty({
    required String name,
    required PlyDataType type,
    PlyDataType? listLengthType,
    PlyDataType? listItemType,
  }) = _PlyProperty;

  factory PlyProperty.fromJson(Map<String, dynamic> json) => _$PlyPropertyFromJson(json);
}

@freezed
class PlyVertex with _$PlyVertex {
  const factory PlyVertex({
    required double x,
    required double y,
    required double z,
    double? nx,
    double? ny,
    double? nz,
    int? red,
    int? green,
    int? blue,
    int? alpha,
  }) = _PlyVertex;

  factory PlyVertex.fromJson(Map<String, dynamic> json) => _$PlyVertexFromJson(json);
}

@freezed
class PlyFace with _$PlyFace {
  const factory PlyFace({
    required List<int> vertexIndices,
  }) = _PlyFace;

  factory PlyFace.fromJson(Map<String, dynamic> json) => _$PlyFaceFromJson(json);
}

enum PlyDataType {
  char,
  uchar,
  short,
  ushort,
  int,
  uint,
  float,
  double,
  list,
}

enum PlyFormat {
  ascii,
  binaryLittleEndian,
  binaryBigEndian,
}