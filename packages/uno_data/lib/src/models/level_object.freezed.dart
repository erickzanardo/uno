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
  $Res call({int x, int y, Map<String, String> metadata});
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
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnoLevelObjectCopyWith<$Res>
    implements $UnoLevelObjectCopyWith<$Res> {
  factory _$$_UnoLevelObjectCopyWith(
          _$_UnoLevelObject value, $Res Function(_$_UnoLevelObject) then) =
      __$$_UnoLevelObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y, Map<String, String> metadata});
}

/// @nodoc
class __$$_UnoLevelObjectCopyWithImpl<$Res>
    extends _$UnoLevelObjectCopyWithImpl<$Res, _$_UnoLevelObject>
    implements _$$_UnoLevelObjectCopyWith<$Res> {
  __$$_UnoLevelObjectCopyWithImpl(
      _$_UnoLevelObject _value, $Res Function(_$_UnoLevelObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? metadata = null,
  }) {
    return _then(_$_UnoLevelObject(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
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
class _$_UnoLevelObject implements _UnoLevelObject {
  const _$_UnoLevelObject(
      {required this.x,
      required this.y,
      required final Map<String, String> metadata})
      : _metadata = metadata;

  factory _$_UnoLevelObject.fromJson(Map<String, dynamic> json) =>
      _$$_UnoLevelObjectFromJson(json);

  @override
  final int x;
  @override
  final int y;
  final Map<String, String> _metadata;
  @override
  Map<String, String> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'UnoLevelObject(x: $x, y: $y, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnoLevelObject &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, x, y, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnoLevelObjectCopyWith<_$_UnoLevelObject> get copyWith =>
      __$$_UnoLevelObjectCopyWithImpl<_$_UnoLevelObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnoLevelObjectToJson(
      this,
    );
  }
}

abstract class _UnoLevelObject implements UnoLevelObject {
  const factory _UnoLevelObject(
      {required final int x,
      required final int y,
      required final Map<String, String> metadata}) = _$_UnoLevelObject;

  factory _UnoLevelObject.fromJson(Map<String, dynamic> json) =
      _$_UnoLevelObject.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  Map<String, String> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$_UnoLevelObjectCopyWith<_$_UnoLevelObject> get copyWith =>
      throw _privateConstructorUsedError;
}
