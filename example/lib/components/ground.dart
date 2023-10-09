import 'dart:async';

import 'package:example/main.dart';
import 'package:flame/components.dart';

class Ground extends SpriteComponent with HasGameRef {
  Ground()
      : super(
          size: Vector2.all(AdventureGame.gameTileSize),
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(
      'sprites.png',
      srcPosition: Vector2(16, 32),
      srcSize: Vector2.all(16),
    );
  }
}
