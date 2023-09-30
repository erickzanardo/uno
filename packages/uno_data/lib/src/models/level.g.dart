// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnoLevelImpl _$$UnoLevelImplFromJson(Map<String, dynamic> json) =>
    _$UnoLevelImpl(
      width: json['width'] as int,
      height: json['height'] as int,
      metadata: Map<String, String>.from(json['metadata'] as Map),
      objects: (json['objects'] as List<dynamic>)
          .map((e) => UnoLevelObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UnoLevelImplToJson(_$UnoLevelImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'metadata': instance.metadata,
      'objects': instance.objects,
    };
