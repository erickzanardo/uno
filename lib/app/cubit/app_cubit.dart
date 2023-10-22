import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/repositories/repositories.dart';
import 'package:uno_data/uno_data.dart';

part 'app_state.dart';

typedef GetDirectoryPath = Future<String?> Function();

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required ProjectRepository projectRepository,
    GetDirectoryPath getDirectoryPath = getDirectoryPath,
  })  : _getDirectoryPath = getDirectoryPath,
        _projectRepository = projectRepository,
        super(const AppInitial());

  final GetDirectoryPath _getDirectoryPath;
  final ProjectRepository _projectRepository;

  Future<void> selectProject() async {
    final path = await _getDirectoryPath();
    if (path != null) {
      try {
        emit(const AppLoading());
        final project = await _projectRepository.fetchProject(path);
        emit(AppLoaded(project: project));
      } catch (e) {
        emit(AppLoadError(message: e.toString()));
      }
    }
  }

  Future<void> newProject() async {
    final path = await _getDirectoryPath();
    if (path != null) {
      try {
        emit(const AppLoading());
        final project = await _projectRepository.newProject(path);
        emit(AppLoaded(project: project));
      } catch (e) {
        emit(AppLoadError(message: e.toString()));
      }
    }
  }

  Future<void> reloadProject() async {
    try {
      if (state is AppLoaded) {
        final project = await _projectRepository.fetchProject(
          (state as AppLoaded).project.projecPath,
        );
        emit(AppLoaded(project: project));
      }
    } catch (e) {
      emit(AppLoadError(message: e.toString()));
    }
  }

  void closeProject() {
    emit(const AppInitial());
  }
}
