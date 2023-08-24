import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:path/path.dart' as path;
import 'package:uno/app/cubit/app_cubit.dart';
import 'package:uno/editor/editor.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppCubit>();

    if (cubit.state is! AppLoaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final appState = cubit.state as AppLoaded;

    return Scaffold(
      body: NesContainer(
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  NesIconButton(
                    icon: NesIcons.instance.add,
                    onPress: () {
                      Navigator.of(context).push(EditorPage.route());
                    },
                  ),
                  const SizedBox(width: 16),
                  NesIconButton(
                    icon: NesIcons.instance.redo,
                    onPress: () {
                      //context.read<AppCubit>().loadLevels();
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final level in appState.project.levels)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: NesPressable(
                          onPress: () {
                            Navigator.of(context).push(
                              EditorPage.route(
                                file: path.basename(level),
                              ),
                            );
                          },
                          child: NesContainer(
                            child: Text(
                              path.relative(
                                level,
                                from: appState.project.projecPath,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
