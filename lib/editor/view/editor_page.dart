import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/editor/editor.dart';
import 'package:uno/repositories/repositories.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  static Route<void> route({String file = ''}) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (context) => EditorCubit(
            fileName: file,
            levelRepository: context.read<LevelRepository>(),
          )..loadData(),
          child: const EditorPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditorView();
  }
}
