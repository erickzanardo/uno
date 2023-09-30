import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:uno/repositories/repositories.dart';
import 'package:uno_data/uno_data.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit({
    required String fileName,
    required LevelRepository levelRepository,
    required UnoProject project,
  })  : _fileName = fileName,
        _levelRepository = levelRepository,
        _project = project,
        super(
          EditorState(
            fileName: fileName,
            level: UnoLevel(
              width: 10,
              height: 10,
              objects: [],
              metadata: {...?project.palette.levelMetadata},
            ),
          ),
        );

  final LevelRepository _levelRepository;

  String? _fileName;

  bool get isEdition => _fileName != '';

  final UnoProject _project;

  void selectPaletteItem(UnoPaletteItem item) {
    emit(
      state.copyWith(
        selectedTool: PaletteBrushTool(item),
      ),
    );
  }

  void selectEraser() {
    emit(
      state.copyWith(
        selectedTool: const EraserTool(),
      ),
    );
  }

  void selectCut(UnoLevelObject? object) {
    emit(
      state.copyWith(
        selectedTool: CutTool(object),
      ),
    );
  }

  void selectCopy(UnoLevelObject? object) {
    emit(
      state.copyWith(
        selectedTool: CopyTool(object),
      ),
    );
  }

  void updateFileName(String fileName) {
    emit(state.copyWith(fileName: fileName));
  }

  void increaseLayer() {
    emit(
      state.copyWith(
        currentLayer: state.currentLayer + 1,
      ),
    );
  }

  void decreaseLayer() {
    if (state.currentLayer == 0) {
      return;
    }

    emit(
      state.copyWith(
        currentLayer: state.currentLayer - 1,
      ),
    );
  }

  UnoLevel _removeOutOfBoundsObjects(UnoLevel level) {
    final objects = level.objects.where(
      (object) {
        return object.x < level.width && object.y < level.height;
      },
    ).toList();

    return level.copyWith(objects: objects);
  }

  void updateHeight(String height) {
    try {
      final value = int.parse(height);
      if (value > 0) {
        var level = state.level.copyWith(height: value);
        level = _removeOutOfBoundsObjects(level);
        emit(state.copyWith(level: level));
      }
    } catch (_) {
      // Ignore eventually wrong number format
    }
  }

  void updateWidth(String width) {
    try {
      final value = int.parse(width);
      if (value > 0) {
        var level = state.level.copyWith(width: value);
        level = _removeOutOfBoundsObjects(level);
        emit(state.copyWith(level: level));
      }
    } catch (_) {
      // Ignore eventually wrong number format
    }
  }

  void paintCell(int x, int y) {
    final selectedTool = state.selectedTool;

    final mappedDataObjects = Map.fromEntries(
      state.level.objects.map(
        (object) => MapEntry((object.x, object.y, object.z), object),
      ),
    );

    if (selectedTool is PaletteBrushTool) {
      final selectedItem = selectedTool.item;
      mappedDataObjects[(x, y, state.currentLayer)] = UnoLevelObject(
        x: x,
        y: y,
        z: state.currentLayer,
        metadata: selectedItem.metadata(),
      );
    } else if (selectedTool is EraserTool) {
      mappedDataObjects.remove((x, y, state.currentLayer));
    } else if (selectedTool is CutTool) {
      if (selectedTool.object == null) {
        final cutObject = mappedDataObjects.remove((x, y, state.currentLayer));
        emit(
          state.copyWith(
            selectedTool: CutTool(cutObject),
          ),
        );
      } else {
        emit(state.clearSelectedTool());
        mappedDataObjects[(x, y, state.currentLayer)] =
            selectedTool.object!.copyWith(
          x: x,
          y: y,
        );
      }
    } else if (selectedTool is CopyTool) {
      if (selectedTool.object == null) {
        final cutObject = mappedDataObjects[(x, y, state.currentLayer)];
        emit(
          state.copyWith(
            selectedTool: CopyTool(cutObject),
          ),
        );
      } else {
        mappedDataObjects[(x, y, state.currentLayer)] =
            selectedTool.object!.copyWith(
          x: x,
          y: y,
        );
      }
    }

    emit(
      state.copyWith(
        level: state.level.copyWith(
          objects: mappedDataObjects.values.toList(),
        ),
      ),
    );
  }

  void updateLevelDataObjectData(int x, int y, String key, String value) {
    emit(
      state.copyWith(
        level: state.level.copyWith(
          objects: state.level.objects.map((levelObjectData) {
            if (levelObjectData.x == x && levelObjectData.y == y) {
              final newData = levelObjectData.copyWith(
                metadata: {
                  ...levelObjectData.metadata,
                  key: value,
                },
              );

              return newData;
            } else {
              return levelObjectData;
            }
          }).toList(),
        ),
      ),
    );
  }

  void updateLevelMetadata(String key, String value) {
    emit(
      state.copyWith(
        level: state.level.copyWith(
          metadata: {
            ...state.level.metadata,
            key: value,
          },
        ),
      ),
    );
  }

  void clearObjects() {
    emit(
      state.copyWith(
        level: state.level.copyWith(
          objects: [],
        ),
      ),
    );
  }

  void reloadLevelMetadata() {
    final projectMetadata = _project.palette.levelMetadata ?? {};

    final newMetadata = {
      ...projectMetadata,
      ...state.level.metadata,
    }..removeWhere((key, _) => !projectMetadata.containsKey(key));

    emit(
      state.copyWith(
        level: state.level.copyWith(
          metadata: newMetadata,
        ),
      ),
    );
  }

  void expand({
    required int left,
    required int right,
    required int top,
    required int bottom,
  }) {
    final level = state.level;
    final objects = level.objects.map(
      (object) {
        final x = object.x;
        final y = object.y;

        return object.copyWith(
          x: x + left,
          y: y + top,
        );
      },
    ).toList();

    emit(
      state.copyWith(
        level: level.copyWith(
          width: level.width + left + right,
          height: level.height + top + bottom,
          objects: objects,
        ),
      ),
    );
  }

  Future<void> loadData() async {
    if (state.fileName.isEmpty) {
      return;
    }
    final levelPath = path.join(_project.projecPath, state.fileName);
    final data = await _levelRepository.loadData(levelPath);
    emit(state.copyWith(level: data, status: EditorStatus.loaded));
  }

  Future<void> save() async {
    if (state.fileName.isEmpty) {
      emit(state.copyWith(status: EditorStatus.emptyFileName));
    } else {
      if ((_fileName?.isNotEmpty ?? false) && state.fileName != _fileName) {
        final previousFileName = path.join(
          _project.projecPath,
          _fileName,
        );
        await _levelRepository.deleteLevel(previousFileName);
        _fileName = state.fileName;
      }

      final levelPath = path.join(_project.projecPath, state.fileName);
      await _levelRepository.saveLevel(
        fileName: levelPath,
        data: state.level,
      );

      emit(
        state.copyWith(
          status: EditorStatus.saved,
          lastSaved: DateTime.now(),
        ),
      );
    }
  }
}
