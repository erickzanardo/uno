// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'palette.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnoPalette _$UnoPaletteFromJson(Map<String, dynamic> json) {
  return _UnoPalette.fromJson(json);
}

/// @nodoc
mixin _$UnoPalette {
  List<UnoPaletteItem> get items => throw _privateConstructorUsedError;
  Map<String, String>? get levelMetadata => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnoPaletteCopyWith<UnoPalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnoPaletteCopyWith<$Res> {
  factory $UnoPaletteCopyWith(
          UnoPalette value, $Res Function(UnoPalette) then) =
      _$UnoPaletteCopyWithImpl<$Res, UnoPalette>;
  @useResult
  $Res call(
      {List<UnoPaletteItem> items,
      Map<String, String>? levelMetadata,
      List<String>? categories});
}

/// @nodoc
class _$UnoPaletteCopyWithImpl<$Res, $Val extends UnoPalette>
    implements $UnoPaletteCopyWith<$Res> {
  _$UnoPaletteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? levelMetadata = freezed,
    Object? categories = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UnoPaletteItem>,
      levelMetadata: freezed == levelMetadata
          ? _value.levelMetadata
          : levelMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnoPaletteImplCopyWith<$Res>
    implements $UnoPaletteCopyWith<$Res> {
  factory _$$UnoPaletteImplCopyWith(
          _$UnoPaletteImpl value, $Res Function(_$UnoPaletteImpl) then) =
      __$$UnoPaletteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<UnoPaletteItem> items,
      Map<String, String>? levelMetadata,
      List<String>? categories});
}

/// @nodoc
class __$$UnoPaletteImplCopyWithImpl<$Res>
    extends _$UnoPaletteCopyWithImpl<$Res, _$UnoPaletteImpl>
    implements _$$UnoPaletteImplCopyWith<$Res> {
  __$$UnoPaletteImplCopyWithImpl(
      _$UnoPaletteImpl _value, $Res Function(_$UnoPaletteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? levelMetadata = freezed,
    Object? categories = freezed,
  }) {
    return _then(_$UnoPaletteImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UnoPaletteItem>,
      levelMetadata: freezed == levelMetadata
          ? _value._levelMetadata
          : levelMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnoPaletteImpl implements _UnoPalette {
  const _$UnoPaletteImpl(
      {required final List<UnoPaletteItem> items,
      final Map<String, String>? levelMetadata,
      final List<String>? categories})
      : _items = items,
        _levelMetadata = levelMetadata,
        _categories = categories;

  factory _$UnoPaletteImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnoPaletteImplFromJson(json);

  final List<UnoPaletteItem> _items;
  @override
  List<UnoPaletteItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final Map<String, String>? _levelMetadata;
  @override
  Map<String, String>? get levelMetadata {
    final value = _levelMetadata;
    if (value == null) return null;
    if (_levelMetadata is EqualUnmodifiableMapView) return _levelMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UnoPalette(items: $items, levelMetadata: $levelMetadata, categories: $categories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnoPaletteImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._levelMetadata, _levelMetadata) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_levelMetadata),
      const DeepCollectionEquality().hash(_categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnoPaletteImplCopyWith<_$UnoPaletteImpl> get copyWith =>
      __$$UnoPaletteImplCopyWithImpl<_$UnoPaletteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnoPaletteImplToJson(
      this,
    );
  }
}

abstract class _UnoPalette implements UnoPalette {
  const factory _UnoPalette(
      {required final List<UnoPaletteItem> items,
      final Map<String, String>? levelMetadata,
      final List<String>? categories}) = _$UnoPaletteImpl;

  factory _UnoPalette.fromJson(Map<String, dynamic> json) =
      _$UnoPaletteImpl.fromJson;

  @override
  List<UnoPaletteItem> get items;
  @override
  Map<String, String>? get levelMetadata;
  @override
  List<String>? get categories;
  @override
  @JsonKey(ignore: true)
  _$$UnoPaletteImplCopyWith<_$UnoPaletteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnoPaletteItem _$UnoPaletteItemFromJson(Map<String, dynamic> json) {
  return _UnoPaletteItem.fromJson(json);
}

/// @nodoc
mixin _$UnoPaletteItem {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  Map<String, String> get data => throw _privateConstructorUsedError;
  List<String>? get nonEditableProperties => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get iconSprite => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnoPaletteItemCopyWith<UnoPaletteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnoPaletteItemCopyWith<$Res> {
  factory $UnoPaletteItemCopyWith(
          UnoPaletteItem value, $Res Function(UnoPaletteItem) then) =
      _$UnoPaletteItemCopyWithImpl<$Res, UnoPaletteItem>;
  @useResult
  $Res call(
      {String id,
      String type,
      Map<String, String> data,
      List<String>? nonEditableProperties,
      String? icon,
      String? iconSprite,
      String? category});
}

/// @nodoc
class _$UnoPaletteItemCopyWithImpl<$Res, $Val extends UnoPaletteItem>
    implements $UnoPaletteItemCopyWith<$Res> {
  _$UnoPaletteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? data = null,
    Object? nonEditableProperties = freezed,
    Object? icon = freezed,
    Object? iconSprite = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      nonEditableProperties: freezed == nonEditableProperties
          ? _value.nonEditableProperties
          : nonEditableProperties // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconSprite: freezed == iconSprite
          ? _value.iconSprite
          : iconSprite // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnoPaletteItemImplCopyWith<$Res>
    implements $UnoPaletteItemCopyWith<$Res> {
  factory _$$UnoPaletteItemImplCopyWith(_$UnoPaletteItemImpl value,
          $Res Function(_$UnoPaletteItemImpl) then) =
      __$$UnoPaletteItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      Map<String, String> data,
      List<String>? nonEditableProperties,
      String? icon,
      String? iconSprite,
      String? category});
}

/// @nodoc
class __$$UnoPaletteItemImplCopyWithImpl<$Res>
    extends _$UnoPaletteItemCopyWithImpl<$Res, _$UnoPaletteItemImpl>
    implements _$$UnoPaletteItemImplCopyWith<$Res> {
  __$$UnoPaletteItemImplCopyWithImpl(
      _$UnoPaletteItemImpl _value, $Res Function(_$UnoPaletteItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? data = null,
    Object? nonEditableProperties = freezed,
    Object? icon = freezed,
    Object? iconSprite = freezed,
    Object? category = freezed,
  }) {
    return _then(_$UnoPaletteItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      nonEditableProperties: freezed == nonEditableProperties
          ? _value._nonEditableProperties
          : nonEditableProperties // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      iconSprite: freezed == iconSprite
          ? _value.iconSprite
          : iconSprite // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnoPaletteItemImpl implements _UnoPaletteItem {
  const _$UnoPaletteItemImpl(
      {required this.id,
      required this.type,
      required final Map<String, String> data,
      final List<String>? nonEditableProperties,
      this.icon,
      this.iconSprite,
      this.category})
      : _data = data,
        _nonEditableProperties = nonEditableProperties;

  factory _$UnoPaletteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnoPaletteItemImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  final Map<String, String> _data;
  @override
  Map<String, String> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final List<String>? _nonEditableProperties;
  @override
  List<String>? get nonEditableProperties {
    final value = _nonEditableProperties;
    if (value == null) return null;
    if (_nonEditableProperties is EqualUnmodifiableListView)
      return _nonEditableProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? icon;
  @override
  final String? iconSprite;
  @override
  final String? category;

  @override
  String toString() {
    return 'UnoPaletteItem(id: $id, type: $type, data: $data, nonEditableProperties: $nonEditableProperties, icon: $icon, iconSprite: $iconSprite, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnoPaletteItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._nonEditableProperties, _nonEditableProperties) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconSprite, iconSprite) ||
                other.iconSprite == iconSprite) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_nonEditableProperties),
      icon,
      iconSprite,
      category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnoPaletteItemImplCopyWith<_$UnoPaletteItemImpl> get copyWith =>
      __$$UnoPaletteItemImplCopyWithImpl<_$UnoPaletteItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnoPaletteItemImplToJson(
      this,
    );
  }
}

abstract class _UnoPaletteItem implements UnoPaletteItem {
  const factory _UnoPaletteItem(
      {required final String id,
      required final String type,
      required final Map<String, String> data,
      final List<String>? nonEditableProperties,
      final String? icon,
      final String? iconSprite,
      final String? category}) = _$UnoPaletteItemImpl;

  factory _UnoPaletteItem.fromJson(Map<String, dynamic> json) =
      _$UnoPaletteItemImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  Map<String, String> get data;
  @override
  List<String>? get nonEditableProperties;
  @override
  String? get icon;
  @override
  String? get iconSprite;
  @override
  String? get category;
  @override
  @JsonKey(ignore: true)
  _$$UnoPaletteItemImplCopyWith<_$UnoPaletteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
