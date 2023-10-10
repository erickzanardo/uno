// ignore_for_file: prefer_const_constructors

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

void main() {
  UnoTopViewGame createGame([List<UnoLevelObject> objects = const []]) {
    return UnoTopViewGame(
      level: UnoLevel(
        objects: objects,
        metadata: {},
        width: 10,
        height: 10,
      ),
      tileSize: 16,
    );
  }

  group('UnoObjectComponent', () {
    test('can be instantiated', () {
      expect(
        UnoObjectComponent(
          object: UnoLevelObject(
            x: 0,
            y: 0,
            z: 0,
            metadata: {},
          ),
        ),
        isNotNull,
      );
    });

    testWithGame(
      'correctly calculates its index',
      createGame,
      (game) async {
        final component = UnoObjectComponent(
          position: Vector2.all(32),
          object: UnoLevelObject(
            x: 2,
            y: 2,
            z: 0,
            metadata: {},
          ),
        );
        await game.ensureAdd(component);

        expect(component.currentIndex, (2, 2));
      },
    );

    testWithGame(
      'correctly calculates its index above',
      createGame,
      (game) async {
        final component = UnoObjectComponent(
          position: Vector2.all(32),
          object: UnoLevelObject(
            x: 2,
            y: 2,
            z: 0,
            metadata: {},
          ),
        );
        await game.ensureAdd(component);

        expect(component.indexAbove, (2, 1));
      },
    );

    testWithGame(
      'correctly calculates its index below',
      createGame,
      (game) async {
        final component = UnoObjectComponent(
          position: Vector2.all(32),
          object: UnoLevelObject(
            x: 2,
            y: 2,
            z: 0,
            metadata: {},
          ),
        );
        await game.ensureAdd(component);

        expect(component.indexBelow, (2, 3));
      },
    );

    testWithGame(
      'correctly calculates its left index',
      createGame,
      (game) async {
        final component = UnoObjectComponent(
          position: Vector2.all(32),
          object: UnoLevelObject(
            x: 2,
            y: 2,
            z: 0,
            metadata: {},
          ),
        );
        await game.ensureAdd(component);

        expect(component.indexLeft, (1, 2));
      },
    );

    testWithGame(
      'correctly calculates its right index',
      createGame,
      (game) async {
        final component = UnoObjectComponent(
          position: Vector2.all(32),
          object: UnoLevelObject(
            x: 2,
            y: 2,
            z: 0,
            metadata: {},
          ),
        );
        await game.ensureAdd(component);

        expect(component.indexRight, (3, 2));
      },
    );
  });
}
