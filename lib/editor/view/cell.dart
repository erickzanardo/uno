import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/editor/editor.dart';
import 'package:uno/widgets/widgets.dart';
import 'package:uno_data/uno_data.dart';

class DataObjectCell extends StatelessWidget {
  const DataObjectCell({
    required this.object,
    required this.project,
    required this.child,
    super.key,
  });

  final Cell child;
  final UnoLevelObject object;
  final UnoProject project;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: child,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: NesPressable(
            onPress: () {
              final cubit = context.read<EditorCubit>();
              NesDialog.show<void>(
                context: context,
                builder: (_) {
                  final paletteItems = project.palette.items.where(
                    (element) => element.type == object.metadata['type'],
                  );

                  final nonEditableKeys = paletteItems.isNotEmpty
                      ? paletteItems.first.nonEditableProperties
                      : <String>[];

                  return MetadataDialogForm(
                    data: object.metadata.editableMetadata(),
                    nonEditableKeys: nonEditableKeys ?? [],
                    onChange: (
                      key,
                      value,
                    ) {
                      cubit.updateLevelDataObjectData(
                        object.x,
                        object.y,
                        key,
                        value,
                      );
                    },
                  );
                },
              );
            },
            child: NesTooltip(
              message: 'Edit metadata',
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: NesIcon(
                  size: const Size(
                    14,
                    14,
                  ),
                  iconData: NesIcons.edit,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({
    this.metadata,
    super.key,
  });

  final Map<String, String>? metadata;

  @override
  Widget build(BuildContext context) {
    final icon = metadata?['icon'];
    final iconSprite = metadata?['iconSprite'];

    final hasIcon =
        (icon?.isNotEmpty ?? false) && (iconSprite?.isNotEmpty ?? false);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: metadata == null || hasIcon
            ? Colors.transparent
            : Colors.accents.first,
        //color: object == null
        //    ? Colors.transparent
        //    : Colors.accents[object?.type.index ?? 0],
      ),
      child: metadata != null
          ? hasIcon
              ? UnoSprite(
                  spritePath: icon!,
                  spriteExpression: iconSprite!,
                )
              : Center(child: Text(metadata?['type']?.toInitials() ?? ''))
          : null,
    );
  }
}
