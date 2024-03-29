import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required LevelRepository levelRepository,
  })  : _levelRepository = levelRepository,
        super(const HomeState());

  final LevelRepository _levelRepository;

  Future<void> renameLevel(String oldFileName, String newFileName) async {
    try {
      await _levelRepository.renameLevel(
        oldFileName: oldFileName,
        newFileName: newFileName,
      );
    } on Exception catch (e) {
      emit(
        HomeState(failure: 'Failed to rename level: $e'),
      );
    }
  }

  Future<void> copyLevel(String level, String newPath) async {
    try {
      await _levelRepository.copyLevel(
        level,
        fileName: newPath,
      );
    } on Exception catch (e) {
      emit(
        HomeState(failure: 'Failed to copy level: $e'),
      );
    }
  }
}
