import 'dart:async';

import 'package:example/components/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:spritexp/spritexp.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final levelJson = await Flame.assets.readJson('levels/level_1');
  final level = UnoLevel.fromJson(levelJson);
  runApp(
    GameWidget.controlled(
      gameFactory: () => AdventureGame(level: level),
    ),
  );
}

class AdventureGame extends UnoTopViewGame with HasKeyboardHandlerComponents {
  AdventureGame({required super.level}) : super(tileSize: gameTileSize) {
    registerObjectBuilder('start_point', Player.builder);
    registerObjectBuilder('scorpion', Scorpion.builder);
    registerObjectBuilder(
      'ground',
      (object) => Ground.builder(
        object,
        _groundSprites,
      ),
    );
  }

  late List<Sprite> _groundSprites;

  static const gameTileSize = 16.0;

  @override
  FutureOr<void> onLoad() async {
    final spritesImage = await images.load('sprites.png');
    final groundExp = SpritExp(
      expression: '{0, 48, 16, 16} * 3yx',
    );
    _groundSprites = groundExp / spritesImage;

    await super.onLoad();
  }

  @override
  bool isWalkeable(UnoLevelObject object) {
    const walkableObjects = ['ground'];
    return walkableObjects.contains(object.metadata['type']);
  }
}
