// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ply_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlyDataImpl _$$PlyDataImplFromJson(Map<String, dynamic> json) =>
    _$PlyDataImpl(
      header: PlyHeader.fromJson(json['header'] as Map<String, dynamic>),
      vertices:
          (json['vertices'] as List<dynamic>)
              .map((e) => PlyVertex.fromJson(e as Map<String, dynamic>))
              .toList(),
      faces:
          (json['faces'] as List<dynamic>?)
              ?.map((e) => PlyFace.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PlyDataImplToJson(_$PlyDataImpl instance) =>
    <String, dynamic>{
      'header': instance.header,
      'vertices': instance.vertices,
      'faces': instance.faces,
    };

_$PlyHeaderImpl _$$PlyHeaderImplFromJson(Map<String, dynamic> json) =>
    _$PlyHeaderImpl(
      format: json['format'] as String,
      vertexCount: (json['vertexCount'] as num).toInt(),
      faceCount: (json['faceCount'] as num?)?.toInt(),
      vertexProperties:
          (json['vertexProperties'] as List<dynamic>)
              .map((e) => PlyProperty.fromJson(e as Map<String, dynamic>))
              .toList(),
      faceProperties:
          (json['faceProperties'] as List<dynamic>?)
              ?.map((e) => PlyProperty.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PlyHeaderImplToJson(_$PlyHeaderImpl instance) =>
    <String, dynamic>{
      'format': instance.format,
      'vertexCount': instance.vertexCount,
      'faceCount': instance.faceCount,
      'vertexProperties': instance.vertexProperties,
      'faceProperties': instance.faceProperties,
    };

_$PlyPropertyImpl _$$PlyPropertyImplFromJson(Map<String, dynamic> json) =>
    _$PlyPropertyImpl(
      name: json['name'] as String,
      type: $enumDecode(_$PlyDataTypeEnumMap, json['type']),
      listLengthType: $enumDecodeNullable(
        _$PlyDataTypeEnumMap,
        json['listLengthType'],
      ),
      listItemType: $enumDecodeNullable(
        _$PlyDataTypeEnumMap,
        json['listItemType'],
      ),
    );

Map<String, dynamic> _$$PlyPropertyImplToJson(_$PlyPropertyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PlyDataTypeEnumMap[instance.type]!,
      'listLengthType': _$PlyDataTypeEnumMap[instance.listLengthType],
      'listItemType': _$PlyDataTypeEnumMap[instance.listItemType],
    };

const _$PlyDataTypeEnumMap = {
  PlyDataType.char: 'char',
  PlyDataType.uchar: 'uchar',
  PlyDataType.short: 'short',
  PlyDataType.ushort: 'ushort',
  PlyDataType.int: 'int',
  PlyDataType.uint: 'uint',
  PlyDataType.float: 'float',
  PlyDataType.double: 'double',
  PlyDataType.list: 'list',
};

_$PlyVertexImpl _$$PlyVertexImplFromJson(Map<String, dynamic> json) =>
    _$PlyVertexImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      z: (json['z'] as num).toDouble(),
      nx: (json['nx'] as num?)?.toDouble(),
      ny: (json['ny'] as num?)?.toDouble(),
      nz: (json['nz'] as num?)?.toDouble(),
      red: (json['red'] as num?)?.toInt(),
      green: (json['green'] as num?)?.toInt(),
      blue: (json['blue'] as num?)?.toInt(),
      alpha: (json['alpha'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PlyVertexImplToJson(_$PlyVertexImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'nx': instance.nx,
      'ny': instance.ny,
      'nz': instance.nz,
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
    };

_$PlyFaceImpl _$$PlyFaceImplFromJson(Map<String, dynamic> json) =>
    _$PlyFaceImpl(
      vertexIndices:
          (json['vertexIndices'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
    );

Map<String, dynamic> _$$PlyFaceImplToJson(_$PlyFaceImpl instance) =>
    <String, dynamic>{'vertexIndices': instance.vertexIndices};
