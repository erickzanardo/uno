import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/repositories/repositories.dart';
import 'package:uno_data/uno_data.dart';

part 'edit_project_state.dart';

class EditProjectCubit extends Cubit<EditProjectState> {
  EditProjectCubit({
    required UnoProject project,
    required ProjectRepository projectRepository,
  })  : _project = project,
        _projectRepository = projectRepository,
        super(
          EditProjectState(
            palette: project.palette,
            status: EditProjectStatus.saved,
          ),
        );

  final ProjectRepository _projectRepository;
  final UnoProject _project;

  Future<void> updatePaletteItem({
    required String itemId,
    required Map<String, String> data,
    required List<String> nonEditableKeys,
  }) async {
    final newPalette = state.palette.copyWith(
      items: state.palette.items.map(
        (item) {
          if (item.id == itemId) {
            return UnoPaletteItem.fromMetadata(data)
                .copyWith(nonEditableProperties: nonEditableKeys);
          }
          return item;
        },
      ).toList(),
    );

    await _savePalette(newPalette);
  }

  Future<void> _savePalette(UnoPalette newPalette) async {
    emit(
      state.copyWith(palette: newPalette, status: EditProjectStatus.saving),
    );
    try {
      await _projectRepository.savePalette(
        _project.projecPath,
        newPalette,
      );
      emit(state.copyWith(status: EditProjectStatus.saved));
    } catch (_) {
      emit(state.copyWith(status: EditProjectStatus.failed));
    }
  }

  void addPaletteItem() {
    final newPalette = state.palette.copyWith(
      items: [
        const UnoPaletteItem(
          id: '',
          type: '',
          data: {},
        ),
        ...state.palette.items,
      ],
    );

    _savePalette(newPalette);
  }

  void copyPaletteItem(UnoPaletteItem item) {
    final newItem = item.copyWith(id: '${item.id}_copy');

    final index = state.palette.items.indexOf(item);

    final newPalette = state.palette.copyWith(
      items: [
        ...state.palette.items.sublist(0, index),
        newItem,
        ...state.palette.items.sublist(index),
      ],
    );

    _savePalette(newPalette);
  }

  void removePaletteItem({required String itemId}) {
    final newPalette = state.palette.copyWith(
      items: state.palette.items.where((item) => item.id != itemId).toList(),
    );

    _savePalette(newPalette);
  }

  void addPaletteCategory(String category) {
    if (state.palette.categories?.contains(category) ?? false) {
      return;
    }

    final newPalette = state.palette.copyWith(
      categories: [
        ...state.palette.categories ?? [],
        category,
      ],
    );

    _savePalette(newPalette);
  }

  void removePaletteCategory(String category) {
    final newPalette = state.palette.copyWith(
      categories:
          state.palette.categories?.where((c) => c != category).toList(),
    );

    _savePalette(newPalette);
  }
}
