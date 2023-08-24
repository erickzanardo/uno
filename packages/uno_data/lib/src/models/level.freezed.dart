// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnoLevel _$UnoLevelFromJson(Map<String, dynamic> json) {
  return _UnoLevel.fromJson(json);
}

/// @nodoc
mixin _$UnoLevel {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  Map<String, String> get metadata => throw _privateConstructorUsedError;
  List<UnoLevelObject> get objects => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnoLevelCopyWith<UnoLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnoLevelCopyWith<$Res> {
  factory $UnoLevelCopyWith(UnoLevel value, $Res Function(UnoLevel) then) =
      _$UnoLevelCopyWithImpl<$Res, UnoLevel>;
  @useResult
  $Res call(
      {int width,
      int height,
      Map<String, String> metadata,
      List<UnoLevelObject> objects});
}

/// @nodoc
class _$UnoLevelCopyWithImpl<$Res, $Val extends UnoLevel>
    implements $UnoLevelCopyWith<$Res> {
  _$UnoLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? metadata = null,
    Object? objects = null,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      objects: null == objects
          ? _value.objects
          : objects // ignore: cast_nullable_to_non_nullable
              as List<UnoLevelObject>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnoLevelCopyWith<$Res> implements $UnoLevelCopyWith<$Res> {
  factory _$$_UnoLevelCopyWith(
          _$_UnoLevel value, $Res Function(_$_UnoLevel) then) =
      __$$_UnoLevelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int width,
      int height,
      Map<String, String> metadata,
      List<UnoLevelObject> objects});
}

/// @nodoc
class __$$_UnoLevelCopyWithImpl<$Res>
    extends _$UnoLevelCopyWithImpl<$Res, _$_UnoLevel>
    implements _$$_UnoLevelCopyWith<$Res> {
  __$$_UnoLevelCopyWithImpl(
      _$_UnoLevel _value, $Res Function(_$_UnoLevel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? metadata = null,
    Object? objects = null,
  }) {
    return _then(_$_UnoLevel(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      objects: null == objects
          ? _value._objects
          : objects // ignore: cast_nullable_to_non_nullable
              as List<UnoLevelObject>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnoLevel implements _UnoLevel {
  const _$_UnoLevel(
      {required this.width,
      required this.height,
      required final Map<String, String> metadata,
      required final List<UnoLevelObject> objects})
      : _metadata = metadata,
        _objects = objects;

  factory _$_UnoLevel.fromJson(Map<String, dynamic> json) =>
      _$$_UnoLevelFromJson(json);

  @override
  final int width;
  @override
  final int height;
  final Map<String, String> _metadata;
  @override
  Map<String, String> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<UnoLevelObject> _objects;
  @override
  List<UnoLevelObject> get objects {
    if (_objects is EqualUnmodifiableListView) return _objects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objects);
  }

  @override
  String toString() {
    return 'UnoLevel(width: $width, height: $height, metadata: $metadata, objects: $objects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnoLevel &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality().equals(other._objects, _objects));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      width,
      height,
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_objects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnoLevelCopyWith<_$_UnoLevel> get copyWith =>
      __$$_UnoLevelCopyWithImpl<_$_UnoLevel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnoLevelToJson(
      this,
    );
  }
}

abstract class _UnoLevel implements UnoLevel {
  const factory _UnoLevel(
      {required final int width,
      required final int height,
      required final Map<String, String> metadata,
      required final List<UnoLevelObject> objects}) = _$_UnoLevel;

  factory _UnoLevel.fromJson(Map<String, dynamic> json) = _$_UnoLevel.fromJson;

  @override
  int get width;
  @override
  int get height;
  @override
  Map<String, String> get metadata;
  @override
  List<UnoLevelObject> get objects;
  @override
  @JsonKey(ignore: true)
  _$$_UnoLevelCopyWith<_$_UnoLevel> get copyWith =>
      throw _privateConstructorUsedError;
}
