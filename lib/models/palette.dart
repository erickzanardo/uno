import 'package:freezed_annotation/freezed_annotation.dart';

part 'palette.freezed.dart';
part 'palette.g.dart';

@freezed
class UnoPalette with _$UnoPalette {
  const factory UnoPalette({
    required List<UnoPaletteItem> items,
  }) = _UnoPalette;

  factory UnoPalette.fromJson(Map<String, dynamic> json) =>
      _$UnoPaletteFromJson(json);
}

@freezed
class UnoPaletteItem with _$UnoPaletteItem {
  const factory UnoPaletteItem({
    required String id,
    required String type,
    required Map<String, String> data,
    String? icon,
    String? iconSprite,
  }) = _UnoPaletteItem;

  factory UnoPaletteItem.fromJson(Map<String, dynamic> json) =>
      _$UnoPaletteItemFromJson(json);
}

extension UnoPaletteItemX on UnoPaletteItem {
  Map<String, String> metadata() => {
        'id': id,
        'type': type,
        'icon': icon ?? '',
        'iconSprite': iconSprite ?? '',
        ...data,
      };
}
