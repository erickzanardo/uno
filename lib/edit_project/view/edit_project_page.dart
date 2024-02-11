import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/app/app.dart';
import 'package:uno/edit_project/edit_project.dart';
import 'package:uno/repositories/repositories.dart';
import 'package:uno_data/uno_data.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) {
            final state = context.read<AppCubit>().state;

            if (state is! AppLoaded) {
              throw Exception('Cannot edit project without a loaded project');
            }

            return EditProjectCubit(
              project: state.project,
              projectRepository: context.read<ProjectRepository>(),
            );
          },
          child: const EditProjectPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditProjectView();
  }
}

class EditProjectView extends StatelessWidget {
  const EditProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<EditProjectCubit>();
    final paletteCategories = cubit.state.palette.categories;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NesContainer(
          width: double.infinity,
          child: NesSingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NesButton(
                  type: NesButtonType.normal,
                  onPressed: () => Navigator.of(context).pop(),
                  child: NesIcon(
                    iconData: NesIcons.leftArrowIndicator,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Palette categories',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: NesTooltip(
                    arrowPlacement: NesTooltipArrowPlacement.right,
                    message: 'Add new palette category',
                    child: NesIconButton(
                      onPress: () async {
                        final name = await NesInputDialog.show(
                          context: context,
                          message: 'Category name',
                        );

                        if (name != null) {
                          cubit.addPaletteCategory(name);
                        }
                      },
                      icon: NesIcons.add,
                    ),
                  ),
                ),
                if (paletteCategories != null && paletteCategories.isNotEmpty)
                  Wrap(
                    children: [
                      for (final category in paletteCategories)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: NesContainer(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(category),
                                const SizedBox(width: 8),
                                NesIconButton(
                                  size: const Size.square(16),
                                  icon: NesIcons.close,
                                  onPress: () async {
                                    final confirmation =
                                        await NesConfirmDialog.show(
                                      context: context,
                                    );

                                    if (confirmation ?? false) {
                                      cubit.removePaletteCategory(category);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
                else
                  const Text('No categories'),
                const SizedBox(height: 32),
                Text(
                  'Project palette',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: NesTooltip(
                    arrowPlacement: NesTooltipArrowPlacement.right,
                    message: 'Add new palette item',
                    child: NesIconButton(
                      onPress: cubit.addPaletteItem,
                      icon: NesIcons.add,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  children: [
                    for (final item in cubit.state.palette.items)
                      _PaletteItemCard(item: item),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaletteItemCard extends StatelessWidget {
  const _PaletteItemCard({
    required this.item,
  });

  final UnoPaletteItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NesContainer(
        width: 360,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in item.metadata().entries)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          entry.value.orEmpty,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 8,
                                  ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                NesIconButton(
                  icon: NesIcons.edit,
                  onPress: () async {
                    final cubit = context.read<EditProjectCubit>();
                    final data = await MetadataDialogForm.show(
                      context,
                      data: item.metadata(),
                      nonEditableKeys: item.nonEditableProperties ?? const [],
                      projectCategories: cubit.state.palette.categories ?? [],
                    );

                    if (data != null) {
                      await cubit.updatePaletteItem(
                        itemId: item.id,
                        data: data.data,
                        nonEditableKeys: data.nonEditableKeys,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                NesIconButton(
                  icon: NesIcons.copy,
                  onPress: () {
                    context.read<EditProjectCubit>().copyPaletteItem(item);
                  },
                ),
                const SizedBox(height: 8),
                NesIconButton(
                  icon: NesIcons.delete,
                  onPress: () async {
                    final cubit = context.read<EditProjectCubit>();
                    final data = await NesConfirmDialog.show(context: context);

                    if (data ?? false) {
                      cubit.removePaletteItem(
                        itemId: item.id,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on String {
  String get orEmpty => isEmpty ? '(empty)' : this;
}
