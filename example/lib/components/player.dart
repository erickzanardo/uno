import 'dart:async';

import 'package:example/main.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef {
  Player()
      : super(
          size: Vector2.all(AdventureGame.gameTileSize),
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(
      'sprites.png',
      srcSize: Vector2.all(16),
    );
  }
}
