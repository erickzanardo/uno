import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.freezed.dart';
part 'palette.g.dart';

@freezed

/// {@template uno_palette}
class UnoPalette with _$UnoPalette {
  /// {@macro uno_palette}
  const factory UnoPalette({
    required List<UnoPaletteItem> items,
    Map<String, String>? levelMetadata,
  }) = _UnoPalette;

  /// {@macro uno_palette}
  factory UnoPalette.fromJson(Map<String, dynamic> json) =>
      _$UnoPaletteFromJson(json);
}

@freezed

/// {@template uno_palette_item}
class UnoPaletteItem with _$UnoPaletteItem {
  /// {@macro uno_palette_item}
  const factory UnoPaletteItem({
    required String id,
    required String type,
    required Map<String, String> data,
    String? icon,
    String? iconSprite,
  }) = _UnoPaletteItem;

  /// {@macro uno_palette_item}
  factory UnoPaletteItem.fromJson(Map<String, dynamic> json) =>
      _$UnoPaletteItemFromJson(json);
}

/// Adds additional functionality to [UnoPaletteItem].
extension UnoPaletteItemX on UnoPaletteItem {
  /// Returns all the metadata of this item.
  Map<String, String> metadata() => {
        'id': id,
        'type': type,
        'icon': icon ?? '',
        'iconSprite': iconSprite ?? '',
        ...data,
      };
}
