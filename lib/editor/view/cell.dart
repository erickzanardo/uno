import 'dart:io';
import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:path/path.dart' as path;
import 'package:spritexp/spritexp.dart';
import 'package:uno/app/app.dart';
import 'package:uno/editor/editor.dart';
import 'package:uno_data/uno_data.dart';

class DataObjectCell extends StatelessWidget {
  const DataObjectCell({
    required this.object,
    required this.child,
    super.key,
  });

  final Cell child;
  final UnoLevelObject object;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: child,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: NesPressable(
            onPress: () {
              NesDialog.show<void>(
                context: context,
                builder: (_) {
                  return MetadataDialogForm(
                    data: object.metadata.editableMetadata(),
                    onChange: (
                      key,
                      value,
                    ) {
                      context.read<EditorCubit>().updateLevelDataObjectData(
                            object.x,
                            object.y,
                            key,
                            value,
                          );
                    },
                  );
                },
              );
            },
            child: NesTooltip(
              message: 'Edit metadata',
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: NesIcon(
                  size: const Size(
                    14,
                    14,
                  ),
                  iconData: NesIcons.edit,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({
    this.metadata,
    super.key,
  });

  final Map<String, String>? metadata;

  @override
  Widget build(BuildContext context) {
    final icon = metadata?['icon'];
    final iconSprite = metadata?['iconSprite'];

    final hasIcon =
        (icon?.isNotEmpty ?? false) && (iconSprite?.isNotEmpty ?? false);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: metadata == null || hasIcon
            ? Colors.transparent
            : Colors.accents.first,
        //color: object == null
        //    ? Colors.transparent
        //    : Colors.accents[object?.type.index ?? 0],
      ),
      child: metadata != null
          ? hasIcon
              ? _CellIcon(
                  spritePath: icon!,
                  spriteExpression: iconSprite!,
                )
              : Center(child: Text(metadata?['type']?.toInitials() ?? ''))
          : null,
    );
  }
}

class _CellIcon extends StatelessWidget {
  const _CellIcon({
    required this.spritePath,
    required this.spriteExpression,
  });

  final String spritePath;
  final String spriteExpression;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: Flame.images.fetchOrGenerate(spritePath, () async {
        final appState = context.read<AppCubit>().state;
        if (appState is! AppLoaded) {
          throw Exception('App is not loaded');
        }

        final projectPath = appState.project.projecPath;
        final imagePath = path.join(projectPath, spritePath);
        final bytes = await File(imagePath).readAsBytes();
        return decodeImageFromList(bytes);
      }),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.hasData && data != null) {
          final sprites = SpritExp(expression: spriteExpression) / data;
          return SpriteWidget(
            sprite: sprites.first,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
