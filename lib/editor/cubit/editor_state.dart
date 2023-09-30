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

class CopyTool extends SelectedTool {
  const CopyTool(this.object);

  final UnoLevelObject? object;

  @override
  List<Object?> get props => [object];
}

class EditorState extends Equatable {
  const EditorState({
    required this.fileName,
    required this.level,
    this.currentLayer = 0,
    this.totalLayers = 1,
    this.status = EditorStatus.initial,
    this.selectedTool,
    this.lastSaved,
  });

  final String fileName;

  final UnoLevel level;

  final SelectedTool? selectedTool;

  final EditorStatus status;

  final DateTime? lastSaved;

  final int currentLayer;

  final int totalLayers;

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
    int? currentLayer,
    int? totalLayers,
  }) {
    return EditorState(
      fileName: fileName ?? this.fileName,
      level: level ?? this.level,
      status: status ?? this.status,
      selectedTool: selectedTool ?? this.selectedTool,
      lastSaved: lastSaved ?? this.lastSaved,
      currentLayer: currentLayer ?? this.currentLayer,
      totalLayers: totalLayers ?? this.totalLayers,
    );
  }

  @override
  List<Object?> get props => [
        fileName,
        level,
        status,
        selectedTool,
        lastSaved,
        currentLayer,
        totalLayers,
      ];
}
