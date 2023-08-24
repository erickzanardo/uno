// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnoPalette _$$_UnoPaletteFromJson(Map<String, dynamic> json) =>
    _$_UnoPalette(
      items: (json['items'] as List<dynamic>)
          .map((e) => UnoPaletteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      levelMetadata: (json['levelMetadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_UnoPaletteToJson(_$_UnoPalette instance) =>
    <String, dynamic>{
      'items': instance.items,
      'levelMetadata': instance.levelMetadata,
    };

_$_UnoPaletteItem _$$_UnoPaletteItemFromJson(Map<String, dynamic> json) =>
    _$_UnoPaletteItem(
      id: json['id'] as String,
      type: json['type'] as String,
      data: Map<String, String>.from(json['data'] as Map),
      icon: json['icon'] as String?,
      iconSprite: json['iconSprite'] as String?,
    );

Map<String, dynamic> _$$_UnoPaletteItemToJson(_$_UnoPaletteItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'icon': instance.icon,
      'iconSprite': instance.iconSprite,
    };
