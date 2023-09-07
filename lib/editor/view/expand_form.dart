import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nes_ui/nes_ui.dart';

class ExpansionResult {
  const ExpansionResult({
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
  });

  final int left;
  final int right;
  final int top;
  final int bottom;
}

class ExpandForm extends StatefulWidget {
  const ExpandForm({super.key});

  @override
  State<ExpandForm> createState() => _ExpandFormState();
}

class _ExpandFormState extends State<ExpandForm> {
  late final _leftController = TextEditingController()..text = '0';
  late final _rightController = TextEditingController()..text = '0';
  late final _topController = TextEditingController()..text = '0';
  late final _bottomController = TextEditingController()..text = '0';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Column(
        children: [
          Text(
            'Expand grid',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: TextField(
                  controller: _topController,
                  decoration: const InputDecoration(labelText: 'Top'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _leftController,
                  decoration: const InputDecoration(labelText: 'Left'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: TextField(
                  controller: _rightController,
                  decoration: const InputDecoration(labelText: 'Right'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: TextField(
                  controller: _bottomController,
                  decoration: const InputDecoration(labelText: 'Bottom'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NesButton(
                type: NesButtonType.primary,
                child: const Text('Expand'),
                onPressed: () {
                  final left = int.tryParse(_leftController.text) ?? 0;
                  final right = int.tryParse(_rightController.text) ?? 0;
                  final top = int.tryParse(_topController.text) ?? 0;
                  final bottom = int.tryParse(_bottomController.text) ?? 0;

                  Navigator.of(context).pop(
                    ExpansionResult(
                      left: left,
                      right: right,
                      top: top,
                      bottom: bottom,
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              NesButton(
                type: NesButtonType.normal,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
