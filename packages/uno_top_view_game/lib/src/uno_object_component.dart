import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
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

  final _moving = ValueNotifier<(bool?, bool?)>((null, null));

  /// Returns a notifier that indicates if the object is moving.
  ValueNotifier<(bool?, bool?)> get movingNotifier => _moving;

  /// If the object is moving, returns the direction it is moving in (x, y).
  (bool?, bool?) get moving => _moving.value;

  /// Sets the direction that the object is moving in (x, y).
  set moving((bool?, bool?) value) => _moving.value = value;

  bool _busy = false;

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

  /// Returns the object relative to this object, if any.
  ///
  /// By default tries to find objects on the same layer as this object,
  /// that can be changed by passing a [z] value.
  UnoLevelObject? objectRelative(int x, int y, [int? z]) {
    final index = currentIndex;

    final objects = gameRef.objectsMap[(
      index.$1 + x,
      index.$2 + y,
    )];

    if (objects == null || objects.isEmpty) {
      return null;
    } else {
      final layer = objects.where((o) => o.z == (z ?? object.z));

      if (layer.isEmpty) {
        return null;
      } else {
        return layer.first;
      }
    }
  }

  /// Returns the object above this object, if any.
  UnoLevelObject? objectBelow([int? z]) => objectRelative(0, 1, z);

  /// Returns the object below this object, if any.
  UnoLevelObject? objectAbove([int? z]) => objectRelative(0, -1, z);

  /// Returns the object to the left of this object, if any.
  UnoLevelObject? objectLeft([int? z]) => objectRelative(-1, 0, z);

  /// Returns the object to the right of this object, if any.
  UnoLevelObject? objectRight([int? z]) => objectRelative(1, 0, z);

  @override
  @mustCallSuper
  FutureOr<void> onLoad() async {
    await super.onLoad();

    movingNotifier.addListener(_onMove);
  }

  @override
  @mustCallSuper
  void onRemove() {
    movingNotifier.removeListener(_onMove);

    super.onRemove();
  }

  void _onMove() {
    if (!_busy) {
      // TODO(erickzanardo): verify if can move

      final movingX = moving.$1;
      final movingY = moving.$2;

      Vector2? destination;

      if (movingX != null) {
        destination = Vector2(
          position.x + (movingX ? gameRef.tileSize : -gameRef.tileSize),
          position.y,
        );
      } else if (movingY != null) {
        destination = Vector2(
          position.x,
          position.y + (movingY ? gameRef.tileSize : -gameRef.tileSize),
        );
      }

      if (destination != null) {
        _busy = true;
        add(
          _SimpleMoveEffect(
            destination,
            onComplete: () {
              _busy = false;
              if (_moving.value.$1 != null || _moving.value.$2 != null) {
                _onMove();
              }
            },
          ),
        );
      }
    }
  }
}

class _SimpleMoveEffect extends MoveToEffect {
  _SimpleMoveEffect(
    Vector2 destination, {
    VoidCallback? onComplete,
  }) : super(
          destination,
          LinearEffectController(1),
          onComplete: onComplete,
        );
}
