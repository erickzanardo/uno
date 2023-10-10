// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

void main() {
  group('UnoTopViewGame', () {
    test('can be instantiated', () {
      expect(
        UnoTopViewGame(
          level: UnoLevel(
            objects: [],
            metadata: {},
            width: 10,
            height: 10,
          ),
          tileSize: 16,
        ),
        isNotNull,
      );
    });
  });
}
