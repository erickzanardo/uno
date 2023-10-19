import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// {@template bouncing_on_move}
/// A component behavior that bounces the component when its parent is moving.
/// changes direction.
/// {@endtemplate}
class BoundOnMove extends UnoBehaviour with ParentIsA<PositionComponent> {
  /// {@macro bouncing_on_move}
  BoundOnMove({
    Vector2? offset,
    bool startMoving = false,
    double duration = .4,
  })  : _offset = offset ?? Vector2(0, -4),
        _isMoving = startMoving,
        _duration = duration;

  final Vector2 _offset;

  SequenceEffect? _sequenceEffect;
  Vector2? _lastPosition;

  bool _isMoving;

  final double _duration;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    unoObjectComponent.movingNotifier.addListener(_handleChange);

    if (_isMoving) {
      _addSequenceEffect();
    }
  }

  @override
  void onRemove() {
    super.onRemove();

    unoObjectComponent.movingNotifier.removeListener(_handleChange);
  }

  void _handleChange() {
    final isMoving = unoObjectComponent.moving.$1 != null ||
        unoObjectComponent.moving.$2 != null;

    if (isMoving != _isMoving) {
      _isMoving = isMoving;

      if (_isMoving) {
        _addSequenceEffect();
      } else {
        if (_lastPosition != null) {
          parent.position = _lastPosition!;
        }
        if (_sequenceEffect != null) {
          _sequenceEffect?.removeFromParent();
          _sequenceEffect = null;
        }
      }
    }
  }

  void _addSequenceEffect() {
    _lastPosition = parent.position.clone();
    parent.add(
      _sequenceEffect = SequenceEffect(
        [
          MoveByEffect(
            _offset,
            CurvedEffectController(
              _duration / 2,
              Curves.easeIn,
            ),
          ),
          MoveByEffect(
            -_offset,
            CurvedEffectController(
              _duration / 2,
              Curves.easeOut,
            ),
          ),
        ],
        infinite: true,
      ),
    );
  }
}
