import 'dart:async';

import 'package:example/main.dart';
import 'package:flame/components.dart';
import 'package:pathxp/pathxp.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

class Scorpion extends SpriteComponent
    with HasGameRef, ParentIsA<UnoObjectComponent> {
  Scorpion(this.path)
      : super(
          size: Vector2.all(AdventureGame.gameTileSize),
          position: Vector2(0, -AdventureGame.gameTileSize * .4),
        );

  final List<(bool?, bool?)> path;
  late List<(bool?, bool?)> _path;

  static List<PositionComponent> builder(UnoLevelObject object) {
    final pathRaw = object.metadata['path'] as String;
    final pathxp = Pathxp(pathRaw).path;

    final path = pathxp.map((step) {
      return switch (step) {
        PathDirection.T => (null, false),
        PathDirection.B => (null, true),
        PathDirection.L => (false, null),
        PathDirection.R => (true, null),
      };
    }).toList();
    return [
      Scorpion(path),
    ];
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _path = path;
    parent.path = [..._path];
    parent.onPathComplete = () {
      _path = _path.reversed
          .map((e) =>
              (e.$1 == null ? null : !e.$1!, e.$2 == null ? null : !e.$2!))
          .toList();
      parent.path = [..._path];
    };

    sprite = await gameRef.loadSprite(
      'sprites.png',
      srcSize: Vector2.all(16),
      srcPosition: Vector2(48, 0),
    );
  }
}
