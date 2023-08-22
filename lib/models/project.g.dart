// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnoProject _$$_UnoProjectFromJson(Map<String, dynamic> json) =>
    _$_UnoProject(
      projecPath: json['projecPath'] as String,
      levels:
          (json['levels'] as List<dynamic>).map((e) => e as String).toList(),
      palette: UnoPalette.fromJson(json['palette'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UnoProjectToJson(_$_UnoProject instance) =>
    <String, dynamic>{
      'projecPath': instance.projecPath,
      'levels': instance.levels,
      'palette': instance.palette,
    };
