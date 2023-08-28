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
    this.lastSaved,
  });

  final String fileName;

  final UnoLevel level;

  final UnoPaletteItem? selectedItem;

  final EditorStatus status;

  final DateTime? lastSaved;

  EditorState copyWith({
    String? fileName,
    UnoLevel? level,
    EditorStatus? status,
    UnoPaletteItem? selectedItem,
    String? dialogKey,
    DateTime? lastSaved,
  }) {
    return EditorState(
      fileName: fileName ?? this.fileName,
      level: level ?? this.level,
      status: status ?? this.status,
      selectedItem: selectedItem ?? this.selectedItem,
      lastSaved: lastSaved ?? this.lastSaved,
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
        lastSaved,
      ];
}
