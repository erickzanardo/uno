import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uno_data/uno_data.dart';

part 'level.freezed.dart';
part 'level.g.dart';

@freezed

/// {@template uno_level}
/// A level in the game.
/// {@endtemplate}
class UnoLevel with _$UnoLevel {
  /// {@macro uno_level}
  const factory UnoLevel({
    required int width,
    required int height,
    required Map<String, String> metadata,
    required List<UnoLevelObject> objects,
  }) = _UnoLevel;

  /// {@macro uno_level}
  factory UnoLevel.fromJson(Map<String, dynamic> json) =>
      _$UnoLevelFromJson(json);
}
