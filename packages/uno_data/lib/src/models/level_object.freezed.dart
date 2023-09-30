// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnoLevelObject _$UnoLevelObjectFromJson(Map<String, dynamic> json) {
  return _UnoLevelObject.fromJson(json);
}

/// @nodoc
mixin _$UnoLevelObject {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get z => throw _privateConstructorUsedError;
  Map<String, String> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnoLevelObjectCopyWith<UnoLevelObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnoLevelObjectCopyWith<$Res> {
  factory $UnoLevelObjectCopyWith(
          UnoLevelObject value, $Res Function(UnoLevelObject) then) =
      _$UnoLevelObjectCopyWithImpl<$Res, UnoLevelObject>;
  @useResult
  $Res call({int x, int y, int z, Map<String, String> metadata});
}

/// @nodoc
class _$UnoLevelObjectCopyWithImpl<$Res, $Val extends UnoLevelObject>
    implements $UnoLevelObjectCopyWith<$Res> {
  _$UnoLevelObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnoLevelObjectImplCopyWith<$Res>
    implements $UnoLevelObjectCopyWith<$Res> {
  factory _$$UnoLevelObjectImplCopyWith(_$UnoLevelObjectImpl value,
          $Res Function(_$UnoLevelObjectImpl) then) =
      __$$UnoLevelObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y, int z, Map<String, String> metadata});
}

/// @nodoc
class __$$UnoLevelObjectImplCopyWithImpl<$Res>
    extends _$UnoLevelObjectCopyWithImpl<$Res, _$UnoLevelObjectImpl>
    implements _$$UnoLevelObjectImplCopyWith<$Res> {
  __$$UnoLevelObjectImplCopyWithImpl(
      _$UnoLevelObjectImpl _value, $Res Function(_$UnoLevelObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? metadata = null,
  }) {
    return _then(_$UnoLevelObjectImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnoLevelObjectImpl implements _UnoLevelObject {
  const _$UnoLevelObjectImpl(
      {required this.x,
      required this.y,
      required this.z,
      required final Map<String, String> metadata})
      : _metadata = metadata;

  factory _$UnoLevelObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnoLevelObjectImplFromJson(json);

  @override
  final int x;
  @override
  final int y;
  @override
  final int z;
  final Map<String, String> _metadata;
  @override
  Map<String, String> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'UnoLevelObject(x: $x, y: $y, z: $z, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnoLevelObjectImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, x, y, z, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnoLevelObjectImplCopyWith<_$UnoLevelObjectImpl> get copyWith =>
      __$$UnoLevelObjectImplCopyWithImpl<_$UnoLevelObjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnoLevelObjectImplToJson(
      this,
    );
  }
}

abstract class _UnoLevelObject implements UnoLevelObject {
  const factory _UnoLevelObject(
      {required final int x,
      required final int y,
      required final int z,
      required final Map<String, String> metadata}) = _$UnoLevelObjectImpl;

  factory _UnoLevelObject.fromJson(Map<String, dynamic> json) =
      _$UnoLevelObjectImpl.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  int get z;
  @override
  Map<String, String> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$UnoLevelObjectImplCopyWith<_$UnoLevelObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
