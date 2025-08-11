
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {

  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Opacity(
          opacity: 0.2,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}