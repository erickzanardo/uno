part of 'editor_cubit.dart';

enum EditorStatus {
  initial,
  loaded,
  saved,
  emptyFileName,
}

abstract class SelectedTool extends Equatable {
  const SelectedTool();
}

class PaletteBrushTool extends SelectedTool {
  const PaletteBrushTool(this.item);

  final UnoPaletteItem item;

  @override
  List<Object?> get props => [item];
}

class EraserTool extends SelectedTool {
  const EraserTool();

  @override
  List<Object?> get props => [];
}

class CutTool extends SelectedTool {
  const CutTool(this.object);

  final UnoLevelObject? object;

  @override
  List<Object?> get props => [object];
}

class EditorState extends Equatable {
  const EditorState({
    required this.fileName,
    required this.level,
    this.status = EditorStatus.initial,
    this.selectedTool,
    this.lastSaved,
  });

  final String fileName;

  final UnoLevel level;

  final SelectedTool? selectedTool;

  final EditorStatus status;

  final DateTime? lastSaved;

  EditorState clearSelectedTool() {
    return EditorState(
      fileName: fileName,
      level: level,
      status: status,
      lastSaved: lastSaved,
    );
  }

  EditorState copyWith({
    String? fileName,
    UnoLevel? level,
    EditorStatus? status,
    SelectedTool? selectedTool,
    String? dialogKey,
    DateTime? lastSaved,
  }) {
    return EditorState(
      fileName: fileName ?? this.fileName,
      level: level ?? this.level,
      status: status ?? this.status,
      selectedTool: selectedTool ?? this.selectedTool,
      lastSaved: lastSaved ?? this.lastSaved,
    );
  }

  @override
  List<Object?> get props => [
        fileName,
        level,
        status,
        selectedTool,
        lastSaved,
      ];
}
