part of 'editor_cubit.dart';

enum EditorStatus {
  initial,
  loaded,
  saved,
  emptyFileName,
}

class EditorState extends Equatable {
  const EditorState({
    required this.fileName,
    required this.level,
    this.status = EditorStatus.initial,
    this.selectedItem,
  });

  final String fileName;

  final UnoLevel level;

  final UnoPaletteItem? selectedItem;

  final EditorStatus status;

  EditorState copyWith({
    String? fileName,
    UnoLevel? level,
    EditorStatus? status,
    UnoPaletteItem? selectedItem,
    String? dialogKey,
  }) {
    return EditorState(
      fileName: fileName ?? this.fileName,
      level: level ?? this.level,
      status: status ?? this.status,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }

  // Clear the selected object
  EditorState clearSelectedObject() {
    return EditorState(
      fileName: fileName,
      status: status,
      level: level,
    );
  }

  @override
  List<Object?> get props => [
        fileName,
        level,
        status,
        selectedItem,
      ];
}
