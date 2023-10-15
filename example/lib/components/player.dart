import 'dart:async';

import 'package:example/main.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

class Player extends SpriteComponent
    with HasGameRef, ParentIsA<UnoObjectComponent> {
  Player()
      : super(
          size: Vector2.all(AdventureGame.gameTileSize),
          position: Vector2(0, -AdventureGame.gameTileSize * .4),
        );

  static List<PositionComponent> builder(UnoLevelObject object) {
    return [Player()];
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    parent.tilesPerSecond = 4;
    sprite = await gameRef.loadSprite(
      'sprites.png',
      srcSize: Vector2.all(16),
    );

    add(
      KeyboardListenerComponent(
        keyDown: {
          LogicalKeyboardKey.keyW: (_) {
            parent.moving = (null, false);
            return false;
          },
          LogicalKeyboardKey.keyS: (_) {
            parent.moving = (null, true);
            return false;
          },
          LogicalKeyboardKey.keyA: (_) {
            parent.moving = (false, null);
            return false;
          },
          LogicalKeyboardKey.keyD: (_) {
            parent.moving = (true, null);
            return false;
          },
        },
        keyUp: {
          LogicalKeyboardKey.keyW: (_) {
            parent.moving = (null, null);
            return false;
          },
          LogicalKeyboardKey.keyS: (_) {
            parent.moving = (null, null);
            return false;
          },
          LogicalKeyboardKey.keyA: (_) {
            parent.moving = (null, null);
            return false;
          },
          LogicalKeyboardKey.keyD: (_) {
            parent.moving = (null, null);
            return false;
          },
        },
      ),
    );
  }
}
