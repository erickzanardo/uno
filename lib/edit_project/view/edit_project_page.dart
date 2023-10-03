import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/app/app.dart';
import 'package:uno/edit_project/edit_project.dart';
import 'package:uno_data/uno_data.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) {
            final state = context.read<AppCubit>().state;

            final palette = state is AppLoaded
                ? state.project.palette
                : const UnoPalette(items: []);

            return EditProjectCubit(palette: palette);
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NesContainer(
          width: double.infinity,
          child: NesSingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Project palette',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
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
            NesIconButton(
              icon: NesIcons.edit,
              onPress: () async {
                final cubit = context.read<EditProjectCubit>();
                final data = await MetadataDialogForm.show(
                  context,
                  data: item.metadata(),
                );

                if (data != null) {
                  cubit.updatePaletteItem(itemId: item.id, data: data);
                }
              },
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
