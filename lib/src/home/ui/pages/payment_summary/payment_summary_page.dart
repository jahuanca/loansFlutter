import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_controller.dart';
import 'package:utils/utils.dart';

class PaymentSummaryPage extends StatelessWidget {
  final PaymentSummaryController controller =
      PaymentSummaryController(getSummaryMonthsUseCase: Get.find());

  PaymentSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentSummaryController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Resumen de pagos', hasArrowBack: true),
        body: ListView.builder(
          itemCount: controller.summary.length,
          itemBuilder: (context, index) => _item(controller.summary[index]),),
      ),
    );
  }

  Widget _item(SummaryMonthResponse summary) {
    return ListTile(
      title: Text(summary.time.format(formatDate: 'MMMM - yyyy').orEmpty()),
      subtitle: Text('S/ ${summary.ganancy.formatDecimals()}'),
    );
  }
}
