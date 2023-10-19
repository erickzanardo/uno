import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// {@template uno_behaviour}
///
/// Base class for Uno Top View Game behaviours.
///
/// It should be added to a component which is a descendant of
/// [UnoObjectComponent].
///
/// {@endtemplate}
abstract class UnoBehaviour extends Component {
  /// {@macro uno_behaviour}
  UnoBehaviour();

  late UnoObjectComponent _parent;

  /// The parent component of this behaviour.
  ///
  /// This should only be accessed after the behaviour is loaded.
  UnoObjectComponent get unoObjectComponent => _parent;

  @mustCallSuper
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    var component = parent;

    // Think on a better solution for this.
    while (component is! UnoObjectComponent) {
      component = component?.parent;
    }

    _parent = component;
  }
}
