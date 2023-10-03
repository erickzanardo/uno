import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/helpers/uno.dart';

class MetadataDialogForm extends StatefulWidget {
  const MetadataDialogForm({
    required this.data,
    super.key,
  });

  final Map<String, String> data;

  static Future<Map<String, String>?> show(
    BuildContext context, {
    required Map<String, String> data,
  }) {
    return NesDialog.show<Map<String, String>>(
      context: context,
      builder: (_) {
        return MetadataDialogForm(data: data);
      },
    );
  }

  @override
  State<MetadataDialogForm> createState() => _MetadataDialogFormState();
}

class _MetadataDialogFormState extends State<MetadataDialogForm> {
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = {
      for (final entry in widget.data.entries)
        entry.key: TextEditingController(text: entry.value),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final entry in _controllers.entries)
              SizedBox(
                width: 440,
                child: Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          TextField(
                            controller: entry.value,
                            decoration: InputDecoration(
                              labelText: entry.key,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (!reservedDataKeys.contains(entry.key))
                      NesIconButton(
                        icon: NesIcons.delete,
                        onPress: () async {
                          final confirm = await NesConfirmDialog.show(
                            context: context,
                            message:
                                'Are you sure you want to delete this key?',
                          );

                          if (confirm ?? false) {
                            setState(() {
                              _controllers.remove(entry.key);
                            });
                          }
                        },
                      ),
                  ],
                ),
              ),
            NesIconButton(
              icon: NesIcons.add,
              onPress: () async {
                final keyName = await NesInputDialog.show(
                  context: context,
                  message: 'Key name',
                );

                if (keyName == null || keyName.isEmpty) {
                  return;
                }

                setState(() {
                  _controllers[keyName] = TextEditingController();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NesButton(
                  type: NesButtonType.normal,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                NesButton(
                  type: NesButtonType.primary,
                  onPressed: () {
                    Navigator.of(context).pop(
                      _controllers.entries.fold<Map<String, String>>(
                        {},
                        (previousValue, element) {
                          previousValue[element.key] = element.value.text;
                          return previousValue;
                        },
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
