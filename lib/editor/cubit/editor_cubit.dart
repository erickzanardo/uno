import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/models/models.dart';
import 'package:uno/repositories/repositories.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit({
    required String fileName,
    required LevelRepository levelRepository,
    required UnoProject project,
  })  : _fileName = fileName,
        _levelRepository = levelRepository,
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

  void clearSelectedObject() {
    emit(state.clearSelectedObject());
  }

  void selectPaletteItem(UnoPaletteItem item) {
    emit(state.copyWith(selectedItem: item));
  }

  void updateFileName(String fileName) {
    emit(state.copyWith(fileName: fileName));
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
    final mappedDataObjects = Map.fromEntries(
      state.level.objects.map(
        (object) => MapEntry((object.x, object.y), object),
      ),
    );

    final selectedItem = state.selectedItem;
    if (selectedItem == null) {
      mappedDataObjects.remove((x, y));
    } else {
      mappedDataObjects[(x, y)] = UnoLevelObject(
        x: x,
        y: y,
        metadata: selectedItem.metadata(),
      );
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

  Future<void> loadData() async {
    if (state.fileName.isEmpty) {
      return;
    }
    final data = await _levelRepository.loadData(state.fileName);
    emit(state.copyWith(level: data, status: EditorStatus.loaded));
  }

  Future<void> save() async {
    if (state.fileName.isEmpty) {
      emit(state.copyWith(status: EditorStatus.emptyFileName));
    } else {
      if ((_fileName?.isNotEmpty ?? false) && state.fileName != _fileName) {
        await _levelRepository.deleteLevel(_fileName!);
        _fileName = state.fileName;
      }

      await _levelRepository.saveLevel(
        fileName: state.fileName,
        data: state.level,
      );
    }
  }
}
