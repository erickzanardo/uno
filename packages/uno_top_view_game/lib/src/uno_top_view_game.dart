import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:uno_data/uno_data.dart';
import 'package:uno_top_view_game/uno_top_view_game.dart';

/// A builder for a list of components based in its [UnoLevelObject].
typedef UnoObjectComponentBuilder = FutureOr<List<Component>> Function(
  UnoLevelObject object,
);

/// {@template uno_top_view_game}
/// A top down view game based on Uno maps.
/// {@endtemplate}
class UnoTopViewGame extends FlameGame {
  /// {@macro uno_top_view_game}
  UnoTopViewGame({
    required this.tileSize,
    required this.level,
    Vector2? resolution,
  }) {
    this.resolution = resolution ?? Vector2(256, 240);
  }

  /// The size of each tile in the game.
  final double tileSize;

  /// The level that this game is running.
  final UnoLevel level;

  /// The map of objects in the game.
  late final Map<(int, int), List<UnoLevelObject>> objectsMap = {};

  /// The map of components in the game, indexed by their index in the grid.
  late final Map<(int, int), List<UnoObjectComponent>> componentsMap = {};

  /// The resolution of the game.
  late final Vector2 resolution;

  final Map<String, UnoObjectComponentBuilder> _objectBuilders = {};

  /// Returns the object at the given index.
  UnoLevelObject? getObjectAt((int, int) index, [int z = 1]) {
    final objects = objectsMap[index];
    final result = objects?.where(
      (o) => o.z == z,
    );
    if (result?.isNotEmpty ?? false) {
      return result!.first;
    } else {
      return null;
    }
  }

  /// Register a builder for an object type.
  void registerObjectBuilder(
    String type,
    UnoObjectComponentBuilder builder,
  ) {
    _objectBuilders[type] = builder;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final stageSize = Vector2(
      level.width * tileSize,
      level.height * tileSize,
    );

    final camera = CameraComponent.withFixedResolution(
      world: world,
      width: resolution.x,
      height: resolution.y,
      // TODO(erickzanardo): We might want to parametrize this!
    )..viewfinder.position = stageSize / 2;

    // Make sure we have all objects mapped.
    for (final obj in level.objects) {
      final i = (obj.x, obj.y);
      objectsMap[i] ??= [];
      objectsMap[(obj.x, obj.y)]?.add(obj);
    }

    for (final obj in level.objects) {
      final type = obj.metadata['type'];
      final builder = _objectBuilders[type];

      if (builder == null) {
        throw ArgumentError(
          'No builder found for object type "$type".',
        );
      }

      final component = UnoObjectComponent(
        object: obj,
        position: Vector2(
          obj.x * tileSize,
          obj.y * tileSize,
        ),
        priority: obj.z,
      );

      final components = await builder(obj);
      await component.addAll(components);

      world.add(component);

      final i = (obj.x, obj.y);
      componentsMap[i] ??= [];
      componentsMap[i]?.add(component);
    }

    this.camera = camera;
  }

  /// Tells if a given object is walkable, by default, returns false,
  /// Override this method to change the behavior.
  bool isWalkeable(UnoLevelObject? object) {
    return false;
  }
}
