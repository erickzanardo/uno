import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.freezed.dart';
part 'palette.g.dart';

@freezed

/// {@template uno_palette}
/// A project palette, which holds the items that can be used in the maps
/// of a project.
/// {@endtemplate}
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
/// A palette item, which is an item that can be used in the maps of a project.
/// {@endtemplate}
class UnoPaletteItem with _$UnoPaletteItem {
  /// {@macro uno_palette_item}
  const factory UnoPaletteItem({
    required String id,
    required String type,
    required Map<String, String> data,
    List<String>? nonEditableProperties,
    String? icon,
    String? iconSprite,
  }) = _UnoPaletteItem;

  /// {@macro uno_palette_item}
  factory UnoPaletteItem.fromJson(Map<String, dynamic> json) =>
      _$UnoPaletteItemFromJson(json);

  /// Creates a [UnoPaletteItem] from the given metadata.
  factory UnoPaletteItem.fromMetadata(Map<String, String> metadata) {
    final id = metadata.remove('id');
    final type = metadata.remove('type');

    if (id == null || type == null) {
      throw ArgumentError('The metadata must contain an id and a type.');
    }

    final icon = metadata.remove('icon');
    final iconSprite = metadata.remove('iconSprite');

    return UnoPaletteItem(
      id: id,
      type: type,
      data: metadata,
      icon: icon,
      iconSprite: iconSprite,
    );
  }
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
