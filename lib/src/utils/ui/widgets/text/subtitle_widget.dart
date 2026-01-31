import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const SubtitleWidget({
    super.key,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        child: Text(text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )));
  }
}
