part of 'edit_project_cubit.dart';

enum EditProjectStatus {
  loading,
  saved,
  saving,
  failed,
}

class EditProjectState extends Equatable {
  const EditProjectState({
    required this.palette,
    required this.status,
  });

  final UnoPalette palette;
  final EditProjectStatus status;

  EditProjectState copyWith({
    UnoPalette? palette,
    EditProjectStatus? status,
  }) {
    return EditProjectState(
      palette: palette ?? this.palette,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [palette, status];
}
