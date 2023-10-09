import 'package:flame/components.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// {@template uno_object_component}
/// The root componnet of all Uno objects.
/// {@endtemplate}
class UnoObjectComponent extends PositionComponent
    with HasGameRef<UnoTopViewGame> {
  /// {@macro uno_object_component}
  UnoObjectComponent({
    required this.object,
    super.position,
    super.priority,
  });

  /// The object that this component represents.
  final UnoLevelObject object;

  /// Returns the current index of this object in the game map.
  (int, int) get currentIndex {
    return (
      position.x ~/ gameRef.tileSize,
      position.y ~/ gameRef.tileSize,
    );
  }

  /// Returns the index of the tile above this object.
  (int, int) get indexAbove {
    final i = currentIndex;
    return (i.$1, i.$2 - 1);
  }

  /// Returns the index of the tile below this object.
  (int, int) get indexBelow {
    final i = currentIndex;
    return (i.$1, i.$2 + 1);
  }

  /// Returns the index of the tile to the left of this object.
  (int, int) get indexLeft {
    final i = currentIndex;
    return (i.$1 - 1, i.$2);
  }

  /// Returns the index of the tile to the right of this object.
  (int, int) get indexRight {
    final i = currentIndex;
    return (i.$1 + 1, i.$2);
  }

  //UnoLevelObject? objectRelative(int x, int y) {
  //  if (this is HasGameRef<LotEternalFlameGame>) {
  //    final game = (this as HasGameRef<LotEternalFlameGame>).gameRef;
  //    final index = currentIndex;
  //    return game.objectsMap[(
  //      index.$1 + x,
  //      index.$2 + y,
  //    )];
  //  }

  //  return null;
  //}

  //UnoLevelObject? get objectBelow => objectRelative(0, 1);
  //UnoLevelObject? get objectAbove => objectRelative(0, -1);
  //UnoLevelObject? get objectLeft => objectRelative(-1, 0);
  //UnoLevelObject? get objectRight => objectRelative(1, 0);
}
