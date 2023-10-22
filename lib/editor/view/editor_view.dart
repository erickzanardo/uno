import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/app/app.dart';
import 'package:uno/editor/editor.dart';
import 'package:uno_data/uno_data.dart';

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
        return (current.status == EditorStatus.loaded &&
                previous.status != current.status) ||
            (current.status == EditorStatus.saved &&
                current.lastSaved != previous.lastSaved);
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
                          icon: NesIcons.saveFile,
                          onPress: () async {
                            await cubit.save();
                          },
                        ),
                        const SizedBox(width: 16),
                        NesIconButton(
                          icon: NesIcons.close,
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
                          NesDialog.show<void>(
                            context: context,
                            builder: (context) {
                              return MetadataDialogForm(
                                data: cubit.state.level.metadata,
                                onChange: cubit.updateLevelMetadata,
                                nonEditableKeys: const [],
                                onReload: () {
                                  cubit.reloadLevelMetadata();
                                  Navigator.of(context).pop();
                                },
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
              const SizedBox(height: 8),
              Align(
                child: NesContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  child: Row(
                    children: [
                      NesTooltip(
                        message: 'Eraser',
                        child: NesIconButton(
                          onPress: () {
                            context.read<EditorCubit>().selectEraser();
                          },
                          icon: NesIcons.eraser,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NesTooltip(
                        message: 'Cut',
                        child: NesIconButton(
                          onPress: () {
                            context.read<EditorCubit>().selectCut(null);
                          },
                          icon: NesIcons.cut,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NesTooltip(
                        message: 'Copy',
                        child: NesIconButton(
                          onPress: () {
                            context.read<EditorCubit>().selectCopy(null);
                          },
                          icon: NesIcons.copy,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('|'),
                      const SizedBox(width: 8),
                      NesTooltip(
                        message: 'Remove all objects',
                        arrowPlacement: NesTooltipArrowPlacement.left,
                        child: NesIconButton(
                          icon: NesIcons.delete,
                          onPress: cubit.clearObjects,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NesTooltip(
                        message: 'Expand',
                        arrowPlacement: NesTooltipArrowPlacement.left,
                        child: NesIconButton(
                          icon: NesIcons.expand,
                          onPress: () async {
                            final cubit = context.read<EditorCubit>();
                            final value = await NesDialog.show<ExpansionResult>(
                              context: context,
                              builder: (context) {
                                return const ExpandForm();
                              },
                            );

                            if (value != null) {
                              cubit.expand(
                                left: value.left,
                                right: value.right,
                                top: value.top,
                                bottom: value.bottom,
                              );

                              // TODO(erickzanardo): Argh, this is not pretty,
                              // but I need this feature ASAP
                              // Leaving as is right now, but I need to refactor
                              // this later.
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                _widthController.text =
                                    cubit.state.level.width.toString();
                                _heightController.text =
                                    cubit.state.level.height.toString();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Stack(
                  children: [
                    Row(
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

                              final mappedDataObjects =
                                  <(int, int), List<UnoLevelObject>>{};

                              final mappedPaletteItems =
                                  Map<String, UnoPaletteItem>.fromEntries(
                                appState.project.palette.items.map(
                                  (e) => MapEntry(e.type, e),
                                ),
                              );

                              for (final object in mapData.objects) {
                                final key = (object.x, object.y);
                                (mappedDataObjects[key] ??= [])
                                  ..add(object)
                                  ..sort((a, b) => a.z.compareTo(b.z));
                              }

                              return Center(
                                child: _Board(
                                  cellSize: cellSize,
                                  mapData: mapData,
                                  cubit: cubit,
                                  mappedDataObjects: mappedDataObjects,
                                  mappedPaletteItems: mappedPaletteItems,
                                  appState: appState,
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: NesContainer(
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
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
                                                  child: Cell(
                                                    metadata: item.metadata(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<EditorCubit, EditorState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    NesIconButton(
                                      icon: NesIcons.remove,
                                      onPress: cubit.decreaseLayer,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Layer: ${state.currentLayer + 1}',
                                    ),
                                    const SizedBox(width: 4),
                                    NesIconButton(
                                      icon: NesIcons.add,
                                      onPress: cubit.increaseLayer,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: NesContainer(
                        padding: const EdgeInsets.all(8),
                        width: 80,
                        height: 80,
                        child: BlocBuilder<EditorCubit, EditorState>(
                          builder: (BuildContext context, EditorState state) {
                            final selectedTool = state.selectedTool;
                            if (selectedTool == null) {
                              return const SizedBox.shrink();
                            } else {
                              if (selectedTool is PaletteBrushTool) {
                                return Cell(
                                  metadata: selectedTool.item.metadata(),
                                );
                              } else if (selectedTool is EraserTool) {
                                return Center(
                                  child: NesIcon(
                                    size: const Size(32, 32),
                                    iconData: NesIcons.eraser,
                                  ),
                                );
                              } else if (selectedTool is CutTool) {
                                final object = selectedTool.object;

                                if (object == null) {
                                  return Center(
                                    child: NesIcon(
                                      size: const Size(32, 32),
                                      iconData: NesIcons.cut,
                                    ),
                                  );
                                } else {
                                  return Stack(
                                    children: [
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        right: 8,
                                        bottom: 8,
                                        child: Cell(
                                          metadata: object.metadata,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: NesIcon(
                                          iconData: NesIcons.cut,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              } else if (selectedTool is CopyTool) {
                                final object = selectedTool.object;

                                if (object == null) {
                                  return Center(
                                    child: NesIcon(
                                      size: const Size(32, 32),
                                      iconData: NesIcons.copy,
                                    ),
                                  );
                                } else {
                                  return Stack(
                                    children: [
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        right: 8,
                                        bottom: 8,
                                        child: Cell(
                                          metadata: object.metadata,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: NesIcon(
                                          iconData: NesIcons.paste,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }

                              return const SizedBox.shrink();
                            }
                          },
                        ),
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

class _Board extends StatelessWidget {
  const _Board({
    required this.cellSize,
    required this.mapData,
    required this.cubit,
    required this.appState,
    required this.mappedDataObjects,
    required this.mappedPaletteItems,
  });

  final double cellSize;
  final UnoLevel mapData;
  final EditorCubit cubit;
  final AppLoaded appState;
  final Map<(int, int), List<UnoLevelObject>> mappedDataObjects;
  final Map<String, UnoPaletteItem> mappedPaletteItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      final key = (x, y);
                      final objects = mappedDataObjects[key];

                      if (objects == null || objects.isEmpty) {
                        return const Cell();
                      } else {
                        return Stack(
                          children: objects
                              .map(
                                (obj) {
                                  final child = Cell(
                                    metadata: obj.metadata,
                                  );

                                  final metadata =
                                      obj.metadata.editableMetadata();

                                  final nonEditableKeys = mappedPaletteItems[
                                              obj.metadataValue('type')]
                                          ?.nonEditableProperties ??
                                      [];

                                  if (metadata.isEmpty ||
                                      nonEditableKeys.length ==
                                          metadata.length) {
                                    return Cell(
                                      metadata: obj.metadata,
                                    );
                                  } else {
                                    return DataObjectCell(
                                      object: obj,
                                      project: appState.project,
                                      child: child,
                                    );
                                  }
                                },
                              )
                              .map(
                                (child) => Positioned.fill(
                                  child: child,
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
