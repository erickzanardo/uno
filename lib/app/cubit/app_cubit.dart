import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/models/models.dart';
import 'package:uno/repositories/level_repository.dart';

part 'app_state.dart';

typedef GetDirectoryPath = Future<String?> Function();

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required LevelRepository levelRepository,
    GetDirectoryPath getDirectoryPath = getDirectoryPath,
  })  : _getDirectoryPath = getDirectoryPath,
        _levelRepository = levelRepository,
        super(const AppInitial());

  final GetDirectoryPath _getDirectoryPath;
  final LevelRepository _levelRepository;

  Future<void> selectProject() async {
    final path = await _getDirectoryPath();
    if (path != null) {
      try {
        emit(const AppLoading());
        final project = await _levelRepository.fetchProject(path);
        emit(AppLoaded(project: project));
      } catch (e) {
        emit(AppLoadError(message: e.toString()));
      }
    }
  }
}
