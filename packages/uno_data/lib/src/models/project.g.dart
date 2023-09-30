// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnoProjectImpl _$$UnoProjectImplFromJson(Map<String, dynamic> json) =>
    _$UnoProjectImpl(
      projecPath: json['projecPath'] as String,
      levels:
          (json['levels'] as List<dynamic>).map((e) => e as String).toList(),
      palette: UnoPalette.fromJson(json['palette'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UnoProjectImplToJson(_$UnoProjectImpl instance) =>
    <String, dynamic>{
      'projecPath': instance.projecPath,
      'levels': instance.levels,
      'palette': instance.palette,
    };
