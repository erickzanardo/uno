// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnoPaletteImpl _$$UnoPaletteImplFromJson(Map<String, dynamic> json) =>
    _$UnoPaletteImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => UnoPaletteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      levelMetadata: (json['levelMetadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UnoPaletteImplToJson(_$UnoPaletteImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'levelMetadata': instance.levelMetadata,
      'categories': instance.categories,
    };

_$UnoPaletteItemImpl _$$UnoPaletteItemImplFromJson(Map<String, dynamic> json) =>
    _$UnoPaletteItemImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      data: Map<String, String>.from(json['data'] as Map),
      nonEditableProperties: (json['nonEditableProperties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      icon: json['icon'] as String?,
      iconSprite: json['iconSprite'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$UnoPaletteItemImplToJson(
        _$UnoPaletteItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'nonEditableProperties': instance.nonEditableProperties,
      'icon': instance.icon,
      'iconSprite': instance.iconSprite,
      'category': instance.category,
    };
