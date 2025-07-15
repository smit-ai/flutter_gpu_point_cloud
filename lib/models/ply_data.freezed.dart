// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ply_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlyData _$PlyDataFromJson(Map<String, dynamic> json) {
  return _PlyData.fromJson(json);
}

/// @nodoc
mixin _$PlyData {
  PlyHeader get header => throw _privateConstructorUsedError;
  List<PlyVertex> get vertices => throw _privateConstructorUsedError;
  List<PlyFace>? get faces => throw _privateConstructorUsedError;

  /// Serializes this PlyData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlyDataCopyWith<PlyData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlyDataCopyWith<$Res> {
  factory $PlyDataCopyWith(PlyData value, $Res Function(PlyData) then) =
      _$PlyDataCopyWithImpl<$Res, PlyData>;
  @useResult
  $Res call({PlyHeader header, List<PlyVertex> vertices, List<PlyFace>? faces});

  $PlyHeaderCopyWith<$Res> get header;
}

/// @nodoc
class _$PlyDataCopyWithImpl<$Res, $Val extends PlyData>
    implements $PlyDataCopyWith<$Res> {
  _$PlyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? vertices = null,
    Object? faces = freezed,
  }) {
    return _then(
      _value.copyWith(
            header:
                null == header
                    ? _value.header
                    : header // ignore: cast_nullable_to_non_nullable
                        as PlyHeader,
            vertices:
                null == vertices
                    ? _value.vertices
                    : vertices // ignore: cast_nullable_to_non_nullable
                        as List<PlyVertex>,
            faces:
                freezed == faces
                    ? _value.faces
                    : faces // ignore: cast_nullable_to_non_nullable
                        as List<PlyFace>?,
          )
          as $Val,
    );
  }

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlyHeaderCopyWith<$Res> get header {
    return $PlyHeaderCopyWith<$Res>(_value.header, (value) {
      return _then(_value.copyWith(header: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlyDataImplCopyWith<$Res> implements $PlyDataCopyWith<$Res> {
  factory _$$PlyDataImplCopyWith(
    _$PlyDataImpl value,
    $Res Function(_$PlyDataImpl) then,
  ) = __$$PlyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlyHeader header, List<PlyVertex> vertices, List<PlyFace>? faces});

  @override
  $PlyHeaderCopyWith<$Res> get header;
}

/// @nodoc
class __$$PlyDataImplCopyWithImpl<$Res>
    extends _$PlyDataCopyWithImpl<$Res, _$PlyDataImpl>
    implements _$$PlyDataImplCopyWith<$Res> {
  __$$PlyDataImplCopyWithImpl(
    _$PlyDataImpl _value,
    $Res Function(_$PlyDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? vertices = null,
    Object? faces = freezed,
  }) {
    return _then(
      _$PlyDataImpl(
        header:
            null == header
                ? _value.header
                : header // ignore: cast_nullable_to_non_nullable
                    as PlyHeader,
        vertices:
            null == vertices
                ? _value._vertices
                : vertices // ignore: cast_nullable_to_non_nullable
                    as List<PlyVertex>,
        faces:
            freezed == faces
                ? _value._faces
                : faces // ignore: cast_nullable_to_non_nullable
                    as List<PlyFace>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlyDataImpl with DiagnosticableTreeMixin implements _PlyData {
  const _$PlyDataImpl({
    required this.header,
    required final List<PlyVertex> vertices,
    final List<PlyFace>? faces,
  }) : _vertices = vertices,
       _faces = faces;

  factory _$PlyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlyDataImplFromJson(json);

  @override
  final PlyHeader header;
  final List<PlyVertex> _vertices;
  @override
  List<PlyVertex> get vertices {
    if (_vertices is EqualUnmodifiableListView) return _vertices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vertices);
  }

  final List<PlyFace>? _faces;
  @override
  List<PlyFace>? get faces {
    final value = _faces;
    if (value == null) return null;
    if (_faces is EqualUnmodifiableListView) return _faces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlyData(header: $header, vertices: $vertices, faces: $faces)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlyData'))
      ..add(DiagnosticsProperty('header', header))
      ..add(DiagnosticsProperty('vertices', vertices))
      ..add(DiagnosticsProperty('faces', faces));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlyDataImpl &&
            (identical(other.header, header) || other.header == header) &&
            const DeepCollectionEquality().equals(other._vertices, _vertices) &&
            const DeepCollectionEquality().equals(other._faces, _faces));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    header,
    const DeepCollectionEquality().hash(_vertices),
    const DeepCollectionEquality().hash(_faces),
  );

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlyDataImplCopyWith<_$PlyDataImpl> get copyWith =>
      __$$PlyDataImplCopyWithImpl<_$PlyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlyDataImplToJson(this);
  }
}

abstract class _PlyData implements PlyData {
  const factory _PlyData({
    required final PlyHeader header,
    required final List<PlyVertex> vertices,
    final List<PlyFace>? faces,
  }) = _$PlyDataImpl;

  factory _PlyData.fromJson(Map<String, dynamic> json) = _$PlyDataImpl.fromJson;

  @override
  PlyHeader get header;
  @override
  List<PlyVertex> get vertices;
  @override
  List<PlyFace>? get faces;

  /// Create a copy of PlyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlyDataImplCopyWith<_$PlyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlyHeader _$PlyHeaderFromJson(Map<String, dynamic> json) {
  return _PlyHeader.fromJson(json);
}

/// @nodoc
mixin _$PlyHeader {
  String get format => throw _privateConstructorUsedError;
  int get vertexCount => throw _privateConstructorUsedError;
  int? get faceCount => throw _privateConstructorUsedError;
  List<PlyProperty> get vertexProperties => throw _privateConstructorUsedError;
  List<PlyProperty>? get faceProperties => throw _privateConstructorUsedError;

  /// Serializes this PlyHeader to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlyHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlyHeaderCopyWith<PlyHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlyHeaderCopyWith<$Res> {
  factory $PlyHeaderCopyWith(PlyHeader value, $Res Function(PlyHeader) then) =
      _$PlyHeaderCopyWithImpl<$Res, PlyHeader>;
  @useResult
  $Res call({
    String format,
    int vertexCount,
    int? faceCount,
    List<PlyProperty> vertexProperties,
    List<PlyProperty>? faceProperties,
  });
}

/// @nodoc
class _$PlyHeaderCopyWithImpl<$Res, $Val extends PlyHeader>
    implements $PlyHeaderCopyWith<$Res> {
  _$PlyHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlyHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? vertexCount = null,
    Object? faceCount = freezed,
    Object? vertexProperties = null,
    Object? faceProperties = freezed,
  }) {
    return _then(
      _value.copyWith(
            format:
                null == format
                    ? _value.format
                    : format // ignore: cast_nullable_to_non_nullable
                        as String,
            vertexCount:
                null == vertexCount
                    ? _value.vertexCount
                    : vertexCount // ignore: cast_nullable_to_non_nullable
                        as int,
            faceCount:
                freezed == faceCount
                    ? _value.faceCount
                    : faceCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            vertexProperties:
                null == vertexProperties
                    ? _value.vertexProperties
                    : vertexProperties // ignore: cast_nullable_to_non_nullable
                        as List<PlyProperty>,
            faceProperties:
                freezed == faceProperties
                    ? _value.faceProperties
                    : faceProperties // ignore: cast_nullable_to_non_nullable
                        as List<PlyProperty>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlyHeaderImplCopyWith<$Res>
    implements $PlyHeaderCopyWith<$Res> {
  factory _$$PlyHeaderImplCopyWith(
    _$PlyHeaderImpl value,
    $Res Function(_$PlyHeaderImpl) then,
  ) = __$$PlyHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String format,
    int vertexCount,
    int? faceCount,
    List<PlyProperty> vertexProperties,
    List<PlyProperty>? faceProperties,
  });
}

/// @nodoc
class __$$PlyHeaderImplCopyWithImpl<$Res>
    extends _$PlyHeaderCopyWithImpl<$Res, _$PlyHeaderImpl>
    implements _$$PlyHeaderImplCopyWith<$Res> {
  __$$PlyHeaderImplCopyWithImpl(
    _$PlyHeaderImpl _value,
    $Res Function(_$PlyHeaderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlyHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? vertexCount = null,
    Object? faceCount = freezed,
    Object? vertexProperties = null,
    Object? faceProperties = freezed,
  }) {
    return _then(
      _$PlyHeaderImpl(
        format:
            null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                    as String,
        vertexCount:
            null == vertexCount
                ? _value.vertexCount
                : vertexCount // ignore: cast_nullable_to_non_nullable
                    as int,
        faceCount:
            freezed == faceCount
                ? _value.faceCount
                : faceCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        vertexProperties:
            null == vertexProperties
                ? _value._vertexProperties
                : vertexProperties // ignore: cast_nullable_to_non_nullable
                    as List<PlyProperty>,
        faceProperties:
            freezed == faceProperties
                ? _value._faceProperties
                : faceProperties // ignore: cast_nullable_to_non_nullable
                    as List<PlyProperty>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlyHeaderImpl with DiagnosticableTreeMixin implements _PlyHeader {
  const _$PlyHeaderImpl({
    required this.format,
    required this.vertexCount,
    this.faceCount,
    required final List<PlyProperty> vertexProperties,
    final List<PlyProperty>? faceProperties,
  }) : _vertexProperties = vertexProperties,
       _faceProperties = faceProperties;

  factory _$PlyHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlyHeaderImplFromJson(json);

  @override
  final String format;
  @override
  final int vertexCount;
  @override
  final int? faceCount;
  final List<PlyProperty> _vertexProperties;
  @override
  List<PlyProperty> get vertexProperties {
    if (_vertexProperties is EqualUnmodifiableListView)
      return _vertexProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vertexProperties);
  }

  final List<PlyProperty>? _faceProperties;
  @override
  List<PlyProperty>? get faceProperties {
    final value = _faceProperties;
    if (value == null) return null;
    if (_faceProperties is EqualUnmodifiableListView) return _faceProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlyHeader(format: $format, vertexCount: $vertexCount, faceCount: $faceCount, vertexProperties: $vertexProperties, faceProperties: $faceProperties)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlyHeader'))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('vertexCount', vertexCount))
      ..add(DiagnosticsProperty('faceCount', faceCount))
      ..add(DiagnosticsProperty('vertexProperties', vertexProperties))
      ..add(DiagnosticsProperty('faceProperties', faceProperties));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlyHeaderImpl &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.vertexCount, vertexCount) ||
                other.vertexCount == vertexCount) &&
            (identical(other.faceCount, faceCount) ||
                other.faceCount == faceCount) &&
            const DeepCollectionEquality().equals(
              other._vertexProperties,
              _vertexProperties,
            ) &&
            const DeepCollectionEquality().equals(
              other._faceProperties,
              _faceProperties,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    format,
    vertexCount,
    faceCount,
    const DeepCollectionEquality().hash(_vertexProperties),
    const DeepCollectionEquality().hash(_faceProperties),
  );

  /// Create a copy of PlyHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlyHeaderImplCopyWith<_$PlyHeaderImpl> get copyWith =>
      __$$PlyHeaderImplCopyWithImpl<_$PlyHeaderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlyHeaderImplToJson(this);
  }
}

abstract class _PlyHeader implements PlyHeader {
  const factory _PlyHeader({
    required final String format,
    required final int vertexCount,
    final int? faceCount,
    required final List<PlyProperty> vertexProperties,
    final List<PlyProperty>? faceProperties,
  }) = _$PlyHeaderImpl;

  factory _PlyHeader.fromJson(Map<String, dynamic> json) =
      _$PlyHeaderImpl.fromJson;

  @override
  String get format;
  @override
  int get vertexCount;
  @override
  int? get faceCount;
  @override
  List<PlyProperty> get vertexProperties;
  @override
  List<PlyProperty>? get faceProperties;

  /// Create a copy of PlyHeader
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlyHeaderImplCopyWith<_$PlyHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlyProperty _$PlyPropertyFromJson(Map<String, dynamic> json) {
  return _PlyProperty.fromJson(json);
}

/// @nodoc
mixin _$PlyProperty {
  String get name => throw _privateConstructorUsedError;
  PlyDataType get type => throw _privateConstructorUsedError;
  PlyDataType? get listLengthType => throw _privateConstructorUsedError;
  PlyDataType? get listItemType => throw _privateConstructorUsedError;

  /// Serializes this PlyProperty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlyProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlyPropertyCopyWith<PlyProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlyPropertyCopyWith<$Res> {
  factory $PlyPropertyCopyWith(
    PlyProperty value,
    $Res Function(PlyProperty) then,
  ) = _$PlyPropertyCopyWithImpl<$Res, PlyProperty>;
  @useResult
  $Res call({
    String name,
    PlyDataType type,
    PlyDataType? listLengthType,
    PlyDataType? listItemType,
  });
}

/// @nodoc
class _$PlyPropertyCopyWithImpl<$Res, $Val extends PlyProperty>
    implements $PlyPropertyCopyWith<$Res> {
  _$PlyPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlyProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? listLengthType = freezed,
    Object? listItemType = freezed,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as PlyDataType,
            listLengthType:
                freezed == listLengthType
                    ? _value.listLengthType
                    : listLengthType // ignore: cast_nullable_to_non_nullable
                        as PlyDataType?,
            listItemType:
                freezed == listItemType
                    ? _value.listItemType
                    : listItemType // ignore: cast_nullable_to_non_nullable
                        as PlyDataType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlyPropertyImplCopyWith<$Res>
    implements $PlyPropertyCopyWith<$Res> {
  factory _$$PlyPropertyImplCopyWith(
    _$PlyPropertyImpl value,
    $Res Function(_$PlyPropertyImpl) then,
  ) = __$$PlyPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    PlyDataType type,
    PlyDataType? listLengthType,
    PlyDataType? listItemType,
  });
}

/// @nodoc
class __$$PlyPropertyImplCopyWithImpl<$Res>
    extends _$PlyPropertyCopyWithImpl<$Res, _$PlyPropertyImpl>
    implements _$$PlyPropertyImplCopyWith<$Res> {
  __$$PlyPropertyImplCopyWithImpl(
    _$PlyPropertyImpl _value,
    $Res Function(_$PlyPropertyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlyProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? listLengthType = freezed,
    Object? listItemType = freezed,
  }) {
    return _then(
      _$PlyPropertyImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as PlyDataType,
        listLengthType:
            freezed == listLengthType
                ? _value.listLengthType
                : listLengthType // ignore: cast_nullable_to_non_nullable
                    as PlyDataType?,
        listItemType:
            freezed == listItemType
                ? _value.listItemType
                : listItemType // ignore: cast_nullable_to_non_nullable
                    as PlyDataType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlyPropertyImpl with DiagnosticableTreeMixin implements _PlyProperty {
  const _$PlyPropertyImpl({
    required this.name,
    required this.type,
    this.listLengthType,
    this.listItemType,
  });

  factory _$PlyPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlyPropertyImplFromJson(json);

  @override
  final String name;
  @override
  final PlyDataType type;
  @override
  final PlyDataType? listLengthType;
  @override
  final PlyDataType? listItemType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlyProperty(name: $name, type: $type, listLengthType: $listLengthType, listItemType: $listItemType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlyProperty'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('listLengthType', listLengthType))
      ..add(DiagnosticsProperty('listItemType', listItemType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlyPropertyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.listLengthType, listLengthType) ||
                other.listLengthType == listLengthType) &&
            (identical(other.listItemType, listItemType) ||
                other.listItemType == listItemType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, type, listLengthType, listItemType);

  /// Create a copy of PlyProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlyPropertyImplCopyWith<_$PlyPropertyImpl> get copyWith =>
      __$$PlyPropertyImplCopyWithImpl<_$PlyPropertyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlyPropertyImplToJson(this);
  }
}

abstract class _PlyProperty implements PlyProperty {
  const factory _PlyProperty({
    required final String name,
    required final PlyDataType type,
    final PlyDataType? listLengthType,
    final PlyDataType? listItemType,
  }) = _$PlyPropertyImpl;

  factory _PlyProperty.fromJson(Map<String, dynamic> json) =
      _$PlyPropertyImpl.fromJson;

  @override
  String get name;
  @override
  PlyDataType get type;
  @override
  PlyDataType? get listLengthType;
  @override
  PlyDataType? get listItemType;

  /// Create a copy of PlyProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlyPropertyImplCopyWith<_$PlyPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlyVertex _$PlyVertexFromJson(Map<String, dynamic> json) {
  return _PlyVertex.fromJson(json);
}

/// @nodoc
mixin _$PlyVertex {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;
  double? get nx => throw _privateConstructorUsedError;
  double? get ny => throw _privateConstructorUsedError;
  double? get nz => throw _privateConstructorUsedError;
  int? get red => throw _privateConstructorUsedError;
  int? get green => throw _privateConstructorUsedError;
  int? get blue => throw _privateConstructorUsedError;
  int? get alpha => throw _privateConstructorUsedError;

  /// Serializes this PlyVertex to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlyVertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlyVertexCopyWith<PlyVertex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlyVertexCopyWith<$Res> {
  factory $PlyVertexCopyWith(PlyVertex value, $Res Function(PlyVertex) then) =
      _$PlyVertexCopyWithImpl<$Res, PlyVertex>;
  @useResult
  $Res call({
    double x,
    double y,
    double z,
    double? nx,
    double? ny,
    double? nz,
    int? red,
    int? green,
    int? blue,
    int? alpha,
  });
}

/// @nodoc
class _$PlyVertexCopyWithImpl<$Res, $Val extends PlyVertex>
    implements $PlyVertexCopyWith<$Res> {
  _$PlyVertexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlyVertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? nx = freezed,
    Object? ny = freezed,
    Object? nz = freezed,
    Object? red = freezed,
    Object? green = freezed,
    Object? blue = freezed,
    Object? alpha = freezed,
  }) {
    return _then(
      _value.copyWith(
            x:
                null == x
                    ? _value.x
                    : x // ignore: cast_nullable_to_non_nullable
                        as double,
            y:
                null == y
                    ? _value.y
                    : y // ignore: cast_nullable_to_non_nullable
                        as double,
            z:
                null == z
                    ? _value.z
                    : z // ignore: cast_nullable_to_non_nullable
                        as double,
            nx:
                freezed == nx
                    ? _value.nx
                    : nx // ignore: cast_nullable_to_non_nullable
                        as double?,
            ny:
                freezed == ny
                    ? _value.ny
                    : ny // ignore: cast_nullable_to_non_nullable
                        as double?,
            nz:
                freezed == nz
                    ? _value.nz
                    : nz // ignore: cast_nullable_to_non_nullable
                        as double?,
            red:
                freezed == red
                    ? _value.red
                    : red // ignore: cast_nullable_to_non_nullable
                        as int?,
            green:
                freezed == green
                    ? _value.green
                    : green // ignore: cast_nullable_to_non_nullable
                        as int?,
            blue:
                freezed == blue
                    ? _value.blue
                    : blue // ignore: cast_nullable_to_non_nullable
                        as int?,
            alpha:
                freezed == alpha
                    ? _value.alpha
                    : alpha // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlyVertexImplCopyWith<$Res>
    implements $PlyVertexCopyWith<$Res> {
  factory _$$PlyVertexImplCopyWith(
    _$PlyVertexImpl value,
    $Res Function(_$PlyVertexImpl) then,
  ) = __$$PlyVertexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double x,
    double y,
    double z,
    double? nx,
    double? ny,
    double? nz,
    int? red,
    int? green,
    int? blue,
    int? alpha,
  });
}

/// @nodoc
class __$$PlyVertexImplCopyWithImpl<$Res>
    extends _$PlyVertexCopyWithImpl<$Res, _$PlyVertexImpl>
    implements _$$PlyVertexImplCopyWith<$Res> {
  __$$PlyVertexImplCopyWithImpl(
    _$PlyVertexImpl _value,
    $Res Function(_$PlyVertexImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlyVertex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? nx = freezed,
    Object? ny = freezed,
    Object? nz = freezed,
    Object? red = freezed,
    Object? green = freezed,
    Object? blue = freezed,
    Object? alpha = freezed,
  }) {
    return _then(
      _$PlyVertexImpl(
        x:
            null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                    as double,
        y:
            null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                    as double,
        z:
            null == z
                ? _value.z
                : z // ignore: cast_nullable_to_non_nullable
                    as double,
        nx:
            freezed == nx
                ? _value.nx
                : nx // ignore: cast_nullable_to_non_nullable
                    as double?,
        ny:
            freezed == ny
                ? _value.ny
                : ny // ignore: cast_nullable_to_non_nullable
                    as double?,
        nz:
            freezed == nz
                ? _value.nz
                : nz // ignore: cast_nullable_to_non_nullable
                    as double?,
        red:
            freezed == red
                ? _value.red
                : red // ignore: cast_nullable_to_non_nullable
                    as int?,
        green:
            freezed == green
                ? _value.green
                : green // ignore: cast_nullable_to_non_nullable
                    as int?,
        blue:
            freezed == blue
                ? _value.blue
                : blue // ignore: cast_nullable_to_non_nullable
                    as int?,
        alpha:
            freezed == alpha
                ? _value.alpha
                : alpha // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlyVertexImpl with DiagnosticableTreeMixin implements _PlyVertex {
  const _$PlyVertexImpl({
    required this.x,
    required this.y,
    required this.z,
    this.nx,
    this.ny,
    this.nz,
    this.red,
    this.green,
    this.blue,
    this.alpha,
  });

  factory _$PlyVertexImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlyVertexImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double z;
  @override
  final double? nx;
  @override
  final double? ny;
  @override
  final double? nz;
  @override
  final int? red;
  @override
  final int? green;
  @override
  final int? blue;
  @override
  final int? alpha;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlyVertex(x: $x, y: $y, z: $z, nx: $nx, ny: $ny, nz: $nz, red: $red, green: $green, blue: $blue, alpha: $alpha)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlyVertex'))
      ..add(DiagnosticsProperty('x', x))
      ..add(DiagnosticsProperty('y', y))
      ..add(DiagnosticsProperty('z', z))
      ..add(DiagnosticsProperty('nx', nx))
      ..add(DiagnosticsProperty('ny', ny))
      ..add(DiagnosticsProperty('nz', nz))
      ..add(DiagnosticsProperty('red', red))
      ..add(DiagnosticsProperty('green', green))
      ..add(DiagnosticsProperty('blue', blue))
      ..add(DiagnosticsProperty('alpha', alpha));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlyVertexImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.nx, nx) || other.nx == nx) &&
            (identical(other.ny, ny) || other.ny == ny) &&
            (identical(other.nz, nz) || other.nz == nz) &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue) &&
            (identical(other.alpha, alpha) || other.alpha == alpha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, x, y, z, nx, ny, nz, red, green, blue, alpha);

  /// Create a copy of PlyVertex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlyVertexImplCopyWith<_$PlyVertexImpl> get copyWith =>
      __$$PlyVertexImplCopyWithImpl<_$PlyVertexImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlyVertexImplToJson(this);
  }
}

abstract class _PlyVertex implements PlyVertex {
  const factory _PlyVertex({
    required final double x,
    required final double y,
    required final double z,
    final double? nx,
    final double? ny,
    final double? nz,
    final int? red,
    final int? green,
    final int? blue,
    final int? alpha,
  }) = _$PlyVertexImpl;

  factory _PlyVertex.fromJson(Map<String, dynamic> json) =
      _$PlyVertexImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get z;
  @override
  double? get nx;
  @override
  double? get ny;
  @override
  double? get nz;
  @override
  int? get red;
  @override
  int? get green;
  @override
  int? get blue;
  @override
  int? get alpha;

  /// Create a copy of PlyVertex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlyVertexImplCopyWith<_$PlyVertexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlyFace _$PlyFaceFromJson(Map<String, dynamic> json) {
  return _PlyFace.fromJson(json);
}

/// @nodoc
mixin _$PlyFace {
  List<int> get vertexIndices => throw _privateConstructorUsedError;

  /// Serializes this PlyFace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlyFace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlyFaceCopyWith<PlyFace> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlyFaceCopyWith<$Res> {
  factory $PlyFaceCopyWith(PlyFace value, $Res Function(PlyFace) then) =
      _$PlyFaceCopyWithImpl<$Res, PlyFace>;
  @useResult
  $Res call({List<int> vertexIndices});
}

/// @nodoc
class _$PlyFaceCopyWithImpl<$Res, $Val extends PlyFace>
    implements $PlyFaceCopyWith<$Res> {
  _$PlyFaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlyFace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? vertexIndices = null}) {
    return _then(
      _value.copyWith(
            vertexIndices:
                null == vertexIndices
                    ? _value.vertexIndices
                    : vertexIndices // ignore: cast_nullable_to_non_nullable
                        as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlyFaceImplCopyWith<$Res> implements $PlyFaceCopyWith<$Res> {
  factory _$$PlyFaceImplCopyWith(
    _$PlyFaceImpl value,
    $Res Function(_$PlyFaceImpl) then,
  ) = __$$PlyFaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> vertexIndices});
}

/// @nodoc
class __$$PlyFaceImplCopyWithImpl<$Res>
    extends _$PlyFaceCopyWithImpl<$Res, _$PlyFaceImpl>
    implements _$$PlyFaceImplCopyWith<$Res> {
  __$$PlyFaceImplCopyWithImpl(
    _$PlyFaceImpl _value,
    $Res Function(_$PlyFaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlyFace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? vertexIndices = null}) {
    return _then(
      _$PlyFaceImpl(
        vertexIndices:
            null == vertexIndices
                ? _value._vertexIndices
                : vertexIndices // ignore: cast_nullable_to_non_nullable
                    as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlyFaceImpl with DiagnosticableTreeMixin implements _PlyFace {
  const _$PlyFaceImpl({required final List<int> vertexIndices})
    : _vertexIndices = vertexIndices;

  factory _$PlyFaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlyFaceImplFromJson(json);

  final List<int> _vertexIndices;
  @override
  List<int> get vertexIndices {
    if (_vertexIndices is EqualUnmodifiableListView) return _vertexIndices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vertexIndices);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlyFace(vertexIndices: $vertexIndices)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlyFace'))
      ..add(DiagnosticsProperty('vertexIndices', vertexIndices));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlyFaceImpl &&
            const DeepCollectionEquality().equals(
              other._vertexIndices,
              _vertexIndices,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_vertexIndices),
  );

  /// Create a copy of PlyFace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlyFaceImplCopyWith<_$PlyFaceImpl> get copyWith =>
      __$$PlyFaceImplCopyWithImpl<_$PlyFaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlyFaceImplToJson(this);
  }
}

abstract class _PlyFace implements PlyFace {
  const factory _PlyFace({required final List<int> vertexIndices}) =
      _$PlyFaceImpl;

  factory _PlyFace.fromJson(Map<String, dynamic> json) = _$PlyFaceImpl.fromJson;

  @override
  List<int> get vertexIndices;

  /// Create a copy of PlyFace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlyFaceImplCopyWith<_$PlyFaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
