import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class PaymentSummaryPage extends StatelessWidget {
  const PaymentSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(text: 'Resumen de pagos', hasArrowBack: true),
      body: const Column(
        children: [],
      ),
    );
  }
}