import 'package:example/components/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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

class AdventureGame extends UnoTopViewGame {
  AdventureGame({required super.level}) : super(tileSize: gameTileSize) {
    registerObjectBuilder('start_point', (_) => [Player()]);
    registerObjectBuilder('ground', (_) => [Ground()]);
  }

  static const gameTileSize = 16.0;
}
