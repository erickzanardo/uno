// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnoLevel _$$_UnoLevelFromJson(Map<String, dynamic> json) => _$_UnoLevel(
      width: json['width'] as int,
      height: json['height'] as int,
      metadata: Map<String, String>.from(json['metadata'] as Map),
      objects: (json['objects'] as List<dynamic>)
          .map((e) => UnoLevelObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UnoLevelToJson(_$_UnoLevel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'metadata': instance.metadata,
      'objects': instance.objects,
    };
