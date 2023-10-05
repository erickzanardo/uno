import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/app/app.dart';
import 'package:uno/repositories/repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final levelRepository = LevelRepository();
  final projectRepository = ProjectRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: levelRepository),
        RepositoryProvider.value(value: projectRepository),
      ],
      child: BlocProvider(
        create: (_) => AppCubit(
          projectRepository: projectRepository,
        ),
        child: const AppView(),
      ),
    ),
  );
}
