import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_data/uno_data.dart';

part 'edit_project_state.dart';

class EditProjectCubit extends Cubit<EditProjectState> {
  EditProjectCubit({
    required UnoPalette palette,
  }) : super(
          EditProjectState(
            palette: palette,
            status: EditProjectStatus.saved,
          ),
        );

  void updatePaletteItem({
    required String itemId,
    required Map<String, String> data,
  }) {
    // TODO
  }
}
