import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/helpers/uno.dart';

class MetadataDialogResult {
  const MetadataDialogResult({
    required this.data,
    required this.nonEditableKeys,
  });

  final Map<String, String> data;
  final List<String> nonEditableKeys;
}

class MetadataDialogForm extends StatefulWidget {
  const MetadataDialogForm({
    required this.data,
    required this.nonEditableKeys,
    super.key,
  });

  final Map<String, String> data;
  final List<String> nonEditableKeys;

  static Future<MetadataDialogResult?> show(
    BuildContext context, {
    required Map<String, String> data,
    required List<String> nonEditableKeys,
  }) {
    return NesDialog.show<MetadataDialogResult>(
      context: context,
      builder: (_) {
        return MetadataDialogForm(
          data: data,
          nonEditableKeys: nonEditableKeys,
        );
      },
    );
  }

  @override
  State<MetadataDialogForm> createState() => _MetadataDialogFormState();
}

class _MetadataDialogFormState extends State<MetadataDialogForm> {
  late Map<String, TextEditingController> _controllers;
  late List<String> _nonEditableKeys;

  @override
  void initState() {
    super.initState();

    _nonEditableKeys = [...widget.nonEditableKeys];

    _controllers = {
      for (final entry in widget.data.entries)
        entry.key: TextEditingController(
          text: entry.value,
        ),
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
                width: 600,
                child: Row(
                  children: [
                    SizedBox(
                      width: 520,
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
                    if (!reservedDataKeys.contains(entry.key)) ...[
                      Opacity(
                        opacity: _nonEditableKeys.contains(entry.key) ? 0.5 : 1,
                        child: NesIconButton(
                          icon: NesIcons.edit,
                          onPress: () async {
                            setState(() {
                              if (_nonEditableKeys.contains(entry.key)) {
                                _nonEditableKeys.remove(entry.key);
                              } else {
                                _nonEditableKeys.add(entry.key);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
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
                    final newData =
                        _controllers.entries.fold<Map<String, String>>(
                      {},
                      (previousValue, element) {
                        previousValue[element.key] = element.value.text;
                        return previousValue;
                      },
                    );

                    Navigator.of(context).pop(
                      MetadataDialogResult(
                        data: newData,
                        nonEditableKeys: _nonEditableKeys,
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
