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
    required int z,
    required Map<String, String> metadata,
  }) = _UnoLevelObject;

  /// {@macro uno_level_object}
  factory UnoLevelObject.fromJson(Map<String, dynamic> json) =>
      _$UnoLevelObjectFromJson(json);
}

/// Utility extension methods for [UnoLevelObject].
extension UnoLevelObjectX on UnoLevelObject {
  /// Gets the value of a metadata key.
  T? metadataValue<T>(String key) {
    final value = metadata[key];
    if (value == null) return null;
    if (T == int) return int.parse(value) as T;
    if (T == double) return double.parse(value) as T;
    if (T == bool) return bool.parse(value) as T;
    return value as T;
  }
}
