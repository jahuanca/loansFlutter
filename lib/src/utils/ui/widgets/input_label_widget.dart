import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class InputLabelWidget extends StatelessWidget {
  final String hintText;
  final String label;

  const InputLabelWidget({
    super.key,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InputWidget(
            isAlignLabel: true,
            hintText: hintText,
            label: label,
            textStyleLabel: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ));
  }
}
