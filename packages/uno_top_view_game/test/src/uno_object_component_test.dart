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
    )..registerObjectBuilder('', (obj) => [PositionComponent()]);
  }

  UnoLevelObject createObject(int x, int y, [int z = 0]) {
    return UnoLevelObject(
      x: x,
      y: y,
      z: z,
      metadata: {'type': ''},
    );
  }

  group('UnoObjectComponent', () {
    test('can be instantiated', () {
      expect(
        UnoObjectComponent(
          object: createObject(0, 0),
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
          object: createObject(2, 2),
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
          object: createObject(2, 2),
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
          object: createObject(2, 2),
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
          object: createObject(2, 2),
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
          object: createObject(2, 2),
        );
        await game.ensureAdd(component);

        expect(component.indexRight, (3, 2));
      },
    );

    testWithGame(
      'correctly calculates objects around it',
      () => createGame(
        [
          createObject(0, 0),
          createObject(1, 0),
          createObject(2, 0),
          createObject(0, 1),
          createObject(1, 1),
          createObject(2, 1),
          createObject(0, 2),
          createObject(1, 2),
          createObject(2, 2),
        ],
      ),
      (game) async {
        final component = game.componentsMap[(1, 1)]!.first;

        final objectBelow = component.objectBelow();
        final objectAbove = component.objectAbove();
        final objectLeft = component.objectLeft();
        final objectRight = component.objectRight();

        expect(objectBelow?.x, equals(1));
        expect(objectBelow?.y, equals(2));

        expect(objectAbove?.x, equals(1));
        expect(objectAbove?.y, equals(0));

        expect(objectLeft?.x, equals(0));
        expect(objectLeft?.y, equals(1));

        expect(objectRight?.x, equals(2));
        expect(objectRight?.y, equals(1));
      },
    );

    testWithGame(
      'correctly calculates objects around it when they are a in different z',
      () => createGame(
        [
          createObject(0, 0, 1),
          createObject(1, 0, 1),
          createObject(2, 0, 1),
          createObject(0, 1, 1),
          createObject(1, 1),
          createObject(2, 1, 1),
          createObject(0, 2, 1),
          createObject(1, 2, 1),
          createObject(2, 2, 1),
        ],
      ),
      (game) async {
        final component = game.componentsMap[(1, 1)]!.first;

        var objectBelow = component.objectBelow();
        var objectAbove = component.objectAbove();
        var objectLeft = component.objectLeft();
        var objectRight = component.objectRight();

        // By default it tries to find in the object's z
        // which should find none in our setup
        expect(objectBelow, isNull);
        expect(objectAbove, isNull);
        expect(objectLeft, isNull);
        expect(objectRight, isNull);

        objectBelow = component.objectBelow(1);
        objectAbove = component.objectAbove(1);
        objectLeft = component.objectLeft(1);
        objectRight = component.objectRight(1);

        // But it is able to find when we try looking in a specific
        // z
        expect(objectBelow?.x, equals(1));
        expect(objectBelow?.y, equals(2));

        expect(objectAbove?.x, equals(1));
        expect(objectAbove?.y, equals(0));

        expect(objectLeft?.x, equals(0));
        expect(objectLeft?.y, equals(1));

        expect(objectRight?.x, equals(2));
        expect(objectRight?.y, equals(1));
      },
    );
  });
}
