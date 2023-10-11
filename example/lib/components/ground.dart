import 'package:example/main.dart';
import 'package:flame/components.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

class Ground extends UnoNineBoxAutoTile {
  Ground({
    required super.nineBoxTileList,
    required super.object,
  }) : super(
          size: Vector2.all(AdventureGame.gameTileSize),
        );
}
