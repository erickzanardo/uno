import 'dart:async';

import 'package:example/main.dart';
import 'package:flame/components.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

class Scorpion extends SpriteComponent
    with HasGameRef, ParentIsA<UnoObjectComponent> {
  Scorpion()
      : super(
          size: Vector2.all(AdventureGame.gameTileSize),
          position: Vector2(0, -AdventureGame.gameTileSize * .4),
        );

  static List<Scorpion> builder(UnoLevelObject object) {
    return [Scorpion()];
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(FlippingSpriteHorizontally(initialDirection: false));
    add(BoundOnMove(startMoving: true, duration: .2, offset: Vector2(0, -2)));

    sprite = await gameRef.loadSprite(
      'sprites.png',
      srcSize: Vector2.all(16),
      srcPosition: Vector2.all(16),
    );
  }
}
