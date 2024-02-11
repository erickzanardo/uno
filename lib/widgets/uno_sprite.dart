import 'dart:io';
import 'dart:ui' as ui;
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:spritexp/spritexp.dart';
import 'package:uno/app/app.dart';

class UnoSprite extends StatelessWidget {
  const UnoSprite({
    required this.spritePath,
    required this.spriteExpression,
    super.key,
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
          try {
            final sprites = SpritExp(expression: spriteExpression) / data;
            return SpriteWidget(
              sprite: sprites.first,
            );
          } catch (_) {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
