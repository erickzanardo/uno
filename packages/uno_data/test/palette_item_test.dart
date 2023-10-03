// ignore_for_file: prefer_const_constructors

import 'package:test/test.dart';
import 'package:uno_data/uno_data.dart';

void main() {
  group('PaletteItem', () {
    test('can be instantiated', () {
      expect(
        UnoPaletteItem(
          id: 'id',
          type: 'type',
          data: {},
        ),
        isNotNull,
      );
    });

    test('can create from the metadata', () {
      expect(
        UnoPaletteItem.fromMetadata(
          {
            'id': 'id',
            'type': 'type',
            'icon': 'icon',
            'iconSprite': 'iconSprite',
            'a': 'b',
            'c': 'd',
          },
        ),
        equals(
          UnoPaletteItem(
            id: 'id',
            type: 'type',
            data: {'a': 'b', 'c': 'd'},
            icon: 'icon',
            iconSprite: 'iconSprite',
          ),
        ),
      );
    });
  });
}
