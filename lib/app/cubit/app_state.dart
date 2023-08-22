part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {

  const AppInitial();

  @override
  List<Object> get props => [];
}

class AppLoading extends AppState {
  const AppLoading();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AppState {
  const AppLoaded({
    required this.project,
  });

  final UnoProject project;

  @override
  List<Object> get props => [project];
}

class AppLoadError extends AppState {
  const AppLoadError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
