import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

export 'editor_page.dart';
export 'editor_view.dart';
export 'metadata_dialog_form.dart';

class MetadataDialogForm extends StatefulWidget {
  const MetadataDialogForm({
    required this.data,
    required this.onChange,
    this.onReload,
    super.key,
  });

  final Map<String, String> data;

  final void Function(String, String) onChange;

  final VoidCallback? onReload;

  @override
  State<MetadataDialogForm> createState() => _MetadataDialogFormState();
}

class _MetadataDialogFormState extends State<MetadataDialogForm> {
  late final Map<String, TextEditingController> _controllers;

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
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.onReload != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: NesTooltip(
                  message: 'Reload with template',
                  child: NesIconButton(
                    icon: NesIcons.instance.redo,
                    onPress: widget.onReload,
                  ),
                ),
              ),
            for (final entry in widget.data.entries)
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _controllers[entry.key],
                      decoration: InputDecoration(
                        labelText: entry.key,
                      ),
                      onChanged: (value) {
                        widget.onChange(entry.key, value);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

