import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_object.freezed.dart';
part 'level_object.g.dart';

@freezed

/// {@template uno_level_object}
/// An object in a level.
/// {@endtemplate}
class UnoLevelObject with _$UnoLevelObject {
  /// {@macro uno_level_object}
  const factory UnoLevelObject({
    required int x,
    required int y,
    required Map<String, String> metadata,
  }) = _UnoLevelObject;

  /// {@macro uno_level_object}
  factory UnoLevelObject.fromJson(Map<String, dynamic> json) =>
      _$UnoLevelObjectFromJson(json);
}
