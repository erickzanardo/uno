import 'package:flame/components.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// {@template uno_nine_box_auto_tile}
/// A comopnent that based in a Nine box tile list, auto tile itself based on
/// its position in relation of its neighbors.
/// {@endtemplate}
class UnoNineBoxAutoTile extends SpriteComponent
    with ParentIsA<UnoObjectComponent> {
  /// {@macro uno_nine_box_auto_tile}
  UnoNineBoxAutoTile({
    required this.nineBoxTileList,
    required this.object,
    super.position,
    super.anchor,
    super.size,
  });

  /// The list of nine box tiles.
  final List<Sprite> nineBoxTileList;

  /// The object that this tile is part of.
  final UnoLevelObject object;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (_isTopLeftCorner()) {
      sprite = nineBoxTileList[0];
    } else if (_isBottomLeftCorner()) {
      sprite = nineBoxTileList[6];
    } else if (_isTopRightCorner()) {
      sprite = nineBoxTileList[2];
    } else if (_isBottomRightCorner()) {
      sprite = nineBoxTileList[8];
    } else if (_isTopEdge()) {
      sprite = nineBoxTileList[1];
    } else if (_isLeftEdge()) {
      sprite = nineBoxTileList[3];
    } else if (_isRightEdge()) {
      sprite = nineBoxTileList[5];
    } else if (_isBottomEdge()) {
      sprite = nineBoxTileList[7];
    } else {
      sprite = nineBoxTileList[4];
    }
  }

  bool _isTopLeftCorner() {
    final objectAbove = parent.objectAbove();
    final objectLeft = parent.objectLeft();

    return objectAbove?.metadata['type'] != object.metadata['type'] &&
        objectLeft?.metadata['type'] != object.metadata['type'];
  }

  bool _isTopRightCorner() {
    final objectAbove = parent.objectAbove();
    final objectRight = parent.objectRight();

    return objectAbove?.metadata['type'] != object.metadata['type'] &&
        objectRight?.metadata['type'] != object.metadata['type'];
  }

  bool _isBottomLeftCorner() {
    final objectLeft = parent.objectLeft();
    final objectBelow = parent.objectBelow();

    return objectLeft?.metadata['type'] != object.metadata['type'] &&
        objectBelow?.metadata['type'] != object.metadata['type'];
  }

  bool _isBottomRightCorner() {
    final objectRight = parent.objectRight();
    final objectBelow = parent.objectBelow();

    return objectRight?.metadata['type'] != object.metadata['type'] &&
        objectBelow?.metadata['type'] != object.metadata['type'];
  }

  bool _isTopEdge() {
    final objectAbove = parent.objectAbove();

    return objectAbove?.metadata['type'] != object.metadata['type'];
  }

  bool _isLeftEdge() {
    final objectLeft = parent.objectLeft();

    return objectLeft?.metadata['type'] != object.metadata['type'];
  }

  bool _isRightEdge() {
    final objectRight = parent.objectRight();

    return objectRight?.metadata['type'] != object.metadata['type'];
  }

  bool _isBottomEdge() {
    final objectBelow = parent.objectBelow();

    return objectBelow?.metadata['type'] != object.metadata['type'];
  }
}
