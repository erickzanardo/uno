import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/home/home.dart';
import 'package:uno/repositories/repositories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        levelRepository: context.read<LevelRepository>(),
      )..loadLevels(),
      child: const HomeView(),
    );
  }
}
