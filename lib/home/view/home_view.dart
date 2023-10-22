import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:path/path.dart' as path;
import 'package:uno/app/cubit/app_cubit.dart';
import 'package:uno/edit_project/edit_project.dart';
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
                  Expanded(
                    child: Row(
                      children: [
                        NesIconButton(
                          icon: NesIcons.add,
                          onPress: () {
                            Navigator.of(context).push(EditorPage.route());
                          },
                        ),
                        const SizedBox(width: 16),
                        NesIconButton(
                          icon: NesIcons.redo,
                          onPress: () {
                            context.read<AppCubit>().reloadProject();
                          },
                        ),
                        const SizedBox(width: 16),
                        const Text('|'),
                        const SizedBox(width: 16),
                        NesTooltip(
                          message: 'Edit project data',
                          child: NesIconButton(
                            icon: NesIcons.edit,
                            onPress: () {
                              Navigator.of(context)
                                  .push(EditProjectPage.route())
                                  .then((_) {
                                cubit.reloadProject();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  NesTooltip(
                    message: 'Close project',
                    child: NesIconButton(
                      icon: NesIcons.close,
                      onPress: () async {
                        final cubit = context.read<AppCubit>();

                        final confirmation = await NesConfirmDialog.show(
                          context: context,
                        );

                        if (confirmation ?? false) {
                          cubit.closeProject();
                        }
                      },
                    ),
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
