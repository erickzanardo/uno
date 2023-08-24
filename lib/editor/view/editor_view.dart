import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:path/path.dart' as path;
import 'package:spritexp/spritexp.dart';
import 'package:uno/app/app.dart';
import 'package:uno/editor/editor.dart';
import 'package:uno/models/models.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  late final _nameController = TextEditingController();
  late final _widthController = TextEditingController();
  late final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<EditorCubit>();
    _nameController.text = cubit.state.fileName;
    _widthController.text = cubit.state.level.width.toString();
    _heightController.text = cubit.state.level.height.toString();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final cubit = context.read<EditorCubit>();

    if (appCubit.state is! AppLoaded) {
      return const Scaffold(
        body: Center(
          child: Text('No project loaded'),
        ),
      );
    }

    final appState = appCubit.state as AppLoaded;

    return BlocListener<EditorCubit, EditorState>(
      listenWhen: (previous, current) {
        return (current.status == EditorStatus.loaded ||
                current.status == EditorStatus.saved) &&
            previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == EditorStatus.loaded) {
          _widthController.text = state.level.width.toString();
          _heightController.text = state.level.height.toString();
        } else if (state.status == EditorStatus.saved) {
          NesSnackbar.show(
            context,
            text: 'Saved',
            type: NesSnackbarType.success,
          );
        }
      },
      child: Scaffold(
        body: NesContainer(
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        NesIconButton(
                          icon: NesIcons.instance.saveFile,
                          onPress: () async {
                            await cubit.save();
                          },
                        ),
                        const SizedBox(width: 16),
                        NesIconButton(
                          icon: NesIcons.instance.close,
                          onPress: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 220,
                      child: Builder(
                        builder: (context) {
                          final status = context.select(
                            (EditorCubit cubit) => cubit.state.status,
                          );
                          return TextField(
                            controller: _nameController,
                            enabled: !cubit.isEdition,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              errorText: status == EditorStatus.emptyFileName
                                  ? 'Empty Name'
                                  : null,
                            ),
                            onChanged: cubit.updateFileName,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _widthController,
                        decoration: const InputDecoration(labelText: 'Width'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: cubit.updateWidth,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _heightController,
                        decoration: const InputDecoration(labelText: 'Height'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: cubit.updateHeight,
                      ),
                    ),
                    if (cubit.state.level.metadata.isNotEmpty)
                      NesButton(
                        type: NesButtonType.normal,
                        onPressed: () {
                          NesDialog.show(
                            context: context,
                            builder: (_) {
                              return _ObjectDialogForm(
                                data: cubit.state.level.metadata,
                                onChange: cubit.updateLevelMetadata,
                              );
                            },
                          );
                        },
                        child: const Text('Metadata'),
                      ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 32),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final mapData = context.select(
                            (EditorCubit cubit) => cubit.state.level,
                          );

                          const padding = 64;
                          final width = constraints.maxWidth - padding;
                          final height = constraints.maxHeight - padding;

                          final cellWidth = width / mapData.width;
                          final cellHeight = height / mapData.height;

                          final cellSize = math.min(cellWidth, cellHeight);

                          final mappedDataObjects = {
                            for (final object in mapData.objects)
                              (object.x, object.y): object,
                          };

                          return Center(
                            child: SizedBox(
                              width: cellSize * mapData.width,
                              height: cellSize * mapData.height,
                              child: Stack(
                                children: [
                                  for (var y = 0; y < mapData.height; y++)
                                    for (var x = 0; x < mapData.width; x++)
                                      Positioned(
                                        left: x * cellSize,
                                        top: y * cellSize,
                                        width: cellSize,
                                        height: cellSize,
                                        child: NesPressable(
                                          onPress: () {
                                            cubit.paintCell(x, y);
                                          },
                                          child: Builder(
                                            builder: (context) {
                                              final child = _Cell(
                                                metadata:
                                                    mappedDataObjects[(x, y)]
                                                        ?.metadata,
                                              );

                                              final dataObject =
                                                  mappedDataObjects[(x, y)];

                                              final metadata = dataObject
                                                  ?.metadata
                                                  .editableMetadata();

                                              if (dataObject == null ||
                                                  (metadata?.isEmpty ??
                                                      false)) {
                                                return _Cell(
                                                  metadata:
                                                      dataObject?.metadata,
                                                );
                                              } else {
                                                return _DataObjectCell(
                                                  object: dataObject,
                                                  child: child,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    NesContainer(
                      height: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                NesPressable(
                                  onPress: cubit.clearSelectedObject,
                                  child: const NesTooltip(
                                    message: 'Clear',
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(child: Text('X')),
                                    ),
                                  ),
                                ),
                                // TODO(erickzanardo): objects palette
                                for (final item
                                    in appState.project.palette.items)
                                  NesTooltip(
                                    message: item.type,
                                    child: NesPressable(
                                      onPress: () {
                                        cubit.selectPaletteItem(item);
                                      },
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: _Cell(metadata: item.metadata()),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Builder(
                            builder: (context) {
                              final selectedItem = context.select(
                                (EditorCubit cubit) => cubit.state.selectedItem,
                              );

                              if (selectedItem == null) {
                                return const Text('X');
                              } else {
                                return _Cell(metadata: selectedItem.metadata());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Map<String, String> {
  Map<String, String> editableMetadata() {
    return {
      for (final entry in entries)
        if (entry.key != 'type' &&
            entry.key != 'id' &&
            entry.key != 'icon' &&
            entry.key != 'iconSprite')
          entry.key: entry.value,
    };
  }
}

class _DataObjectCell extends StatelessWidget {
  const _DataObjectCell({
    required this.object,
    required this.child,
  });

  final _Cell child;
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
              NesDialog.show(
                context: context,
                builder: (_) {
                  return _ObjectDialogForm(
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
            child: NesContainer(
              padding: const EdgeInsets.all(2),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: NesIcon(
                  size: const Size(
                    12,
                    12,
                  ),
                  iconData: NesIcons.instance.sword,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({this.metadata});

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

extension on String {
  String toInitials() {
    late String firstLetter;
    String? lastLetter;

    if (length >= 1) {
      firstLetter = this[0];
    }

    if (length >= 2) {
      lastLetter = this[1];
    }

    return '${firstLetter.toUpperCase()}${lastLetter?.toUpperCase() ?? ''}';
  }
}

class _ObjectDialogForm extends StatefulWidget {
  const _ObjectDialogForm({
    required this.data,
    required this.onChange,
  });

  final Map<String, String> data;

  final void Function(String, String) onChange;

  @override
  State<_ObjectDialogForm> createState() => _ObjectDialogFormState();
}

class _ObjectDialogFormState extends State<_ObjectDialogForm> {
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = {
      for (final entry in widget.data.entries)
        entry.key: TextEditingController(text: entry.value),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final entry in widget.data.entries)
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _controllers[entry.key],
                      decoration: InputDecoration(
                        labelText: entry.key,
                      ),
                      onChanged: (value) {
                        widget.onChange(entry.key, value);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
