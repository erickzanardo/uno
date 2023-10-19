import 'dart:async';

import 'package:flame/components.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// {@template flipping_sprite_horizontally}
/// A component behavior that flips the sprite horizontally when the parent
/// changes direction.
/// {@endtemplate}
class FlippingSpriteHorizontally extends UnoBehaviour
    with ParentIsA<PositionComponent> {
  /// {@macro flipping_sprite_horizontally}
  FlippingSpriteHorizontally({
    bool initialDirection = true,
  }) : _lastDirection = initialDirection;

  bool _lastDirection;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    unoObjectComponent.movingNotifier.addListener(_handleChange);
  }

  @override
  void onRemove() {
    super.onRemove();

    unoObjectComponent.movingNotifier.removeListener(_handleChange);
  }

  void _handleChange() {
    if (unoObjectComponent.moving.$1 != null &&
        unoObjectComponent.moving.$1 != _lastDirection) {
      _lastDirection = unoObjectComponent.moving.$1!;
      parent.flipHorizontallyAroundCenter();
    }
  }
}
