// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnoProject _$UnoProjectFromJson(Map<String, dynamic> json) {
  return _UnoProject.fromJson(json);
}

/// @nodoc
mixin _$UnoProject {
  String get projecPath => throw _privateConstructorUsedError;
  List<String> get levels => throw _privateConstructorUsedError;
  UnoPalette get palette => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnoProjectCopyWith<UnoProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnoProjectCopyWith<$Res> {
  factory $UnoProjectCopyWith(
          UnoProject value, $Res Function(UnoProject) then) =
      _$UnoProjectCopyWithImpl<$Res, UnoProject>;
  @useResult
  $Res call({String projecPath, List<String> levels, UnoPalette palette});

  $UnoPaletteCopyWith<$Res> get palette;
}

/// @nodoc
class _$UnoProjectCopyWithImpl<$Res, $Val extends UnoProject>
    implements $UnoProjectCopyWith<$Res> {
  _$UnoProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projecPath = null,
    Object? levels = null,
    Object? palette = null,
  }) {
    return _then(_value.copyWith(
      projecPath: null == projecPath
          ? _value.projecPath
          : projecPath // ignore: cast_nullable_to_non_nullable
              as String,
      levels: null == levels
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      palette: null == palette
          ? _value.palette
          : palette // ignore: cast_nullable_to_non_nullable
              as UnoPalette,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnoPaletteCopyWith<$Res> get palette {
    return $UnoPaletteCopyWith<$Res>(_value.palette, (value) {
      return _then(_value.copyWith(palette: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UnoProjectCopyWith<$Res>
    implements $UnoProjectCopyWith<$Res> {
  factory _$$_UnoProjectCopyWith(
          _$_UnoProject value, $Res Function(_$_UnoProject) then) =
      __$$_UnoProjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String projecPath, List<String> levels, UnoPalette palette});

  @override
  $UnoPaletteCopyWith<$Res> get palette;
}

/// @nodoc
class __$$_UnoProjectCopyWithImpl<$Res>
    extends _$UnoProjectCopyWithImpl<$Res, _$_UnoProject>
    implements _$$_UnoProjectCopyWith<$Res> {
  __$$_UnoProjectCopyWithImpl(
      _$_UnoProject _value, $Res Function(_$_UnoProject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projecPath = null,
    Object? levels = null,
    Object? palette = null,
  }) {
    return _then(_$_UnoProject(
      projecPath: null == projecPath
          ? _value.projecPath
          : projecPath // ignore: cast_nullable_to_non_nullable
              as String,
      levels: null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      palette: null == palette
          ? _value.palette
          : palette // ignore: cast_nullable_to_non_nullable
              as UnoPalette,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnoProject implements _UnoProject {
  const _$_UnoProject(
      {required this.projecPath,
      required final List<String> levels,
      required this.palette})
      : _levels = levels;

  factory _$_UnoProject.fromJson(Map<String, dynamic> json) =>
      _$$_UnoProjectFromJson(json);

  @override
  final String projecPath;
  final List<String> _levels;
  @override
  List<String> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  final UnoPalette palette;

  @override
  String toString() {
    return 'UnoProject(projecPath: $projecPath, levels: $levels, palette: $palette)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnoProject &&
            (identical(other.projecPath, projecPath) ||
                other.projecPath == projecPath) &&
            const DeepCollectionEquality().equals(other._levels, _levels) &&
            (identical(other.palette, palette) || other.palette == palette));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, projecPath,
      const DeepCollectionEquality().hash(_levels), palette);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnoProjectCopyWith<_$_UnoProject> get copyWith =>
      __$$_UnoProjectCopyWithImpl<_$_UnoProject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnoProjectToJson(
      this,
    );
  }
}

abstract class _UnoProject implements UnoProject {
  const factory _UnoProject(
      {required final String projecPath,
      required final List<String> levels,
      required final UnoPalette palette}) = _$_UnoProject;

  factory _UnoProject.fromJson(Map<String, dynamic> json) =
      _$_UnoProject.fromJson;

  @override
  String get projecPath;
  @override
  List<String> get levels;
  @override
  UnoPalette get palette;
  @override
  @JsonKey(ignore: true)
  _$$_UnoProjectCopyWith<_$_UnoProject> get copyWith =>
      throw _privateConstructorUsedError;
}
