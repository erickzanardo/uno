import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uno/models/models.dart';

part 'level.freezed.dart';
part 'level.g.dart';

@freezed
class UnoLevel with _$UnoLevel {

  const factory UnoLevel({
    required int width,
    required int height,
    required Map<String, String> metadata,
    required List<UnoLevelObject> objects,
  }) = _UnoLevel;

  factory UnoLevel.fromJson(Map<String, dynamic> json) =>
      _$UnoLevelFromJson(json);
}
