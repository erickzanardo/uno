import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_object.freezed.dart';
part 'level_object.g.dart';

@freezed
class UnoLevelObject with _$UnoLevelObject {
  const factory UnoLevelObject({
    required int x,
    required int y,
    required Map<String, String> metadata,
  }) = _UnoLevelObject;

  factory UnoLevelObject.fromJson(Map<String, dynamic> json) =>
      _$UnoLevelObjectFromJson(json);
}
