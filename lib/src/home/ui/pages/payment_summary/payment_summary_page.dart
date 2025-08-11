import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_controller.dart';
import 'package:loands_flutter/src/utils/core/colors.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/ui/widgets/totals_bottoms_widget.dart';
import 'package:utils/utils.dart';

class PaymentSummaryPage extends StatelessWidget {
  final PaymentSummaryController controller =
      PaymentSummaryController(getSummaryMonthsUseCase: Get.find());

  PaymentSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<PaymentSummaryController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getSummaryMonths,
        child: Scaffold(
          appBar: appBarWidget(text: 'Resumen de pagos', hasArrowBack: true),
          bottomNavigationBar: _bottomSection(),
          body: ListView.builder(
            itemCount: controller.summary.length,
            itemBuilder: (context, index) => _item(
              size: size,
              summary: controller.summary[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSection() {
    return TotalsBottomsWidget(values: {
      'Ganancia': controller.totalOfGanancy.formatDecimals(),
      'Perdida': controller.totalOfLoss.formatDecimals(),
      'Total': controller.total.formatDecimals(),
    });
  }

  Widget _item({
    required SummaryMonthResponse summary,
    required Size size,
  }) {
    double amountToShow = (summary.idStateQuota == idOfCompleteLoan)
        ? summary.ganancy
        : summary.amount;

    return ListTile(
      title: SizedBox(
          width: size.width * 0.8,
          child:
              Text(summary.time.format(formatDate: 'MMMM - yyyy').orEmpty())),
      subtitle: Text('S/ ${amountToShow.formatDecimals()}'),
      trailing: SizedBox(
          width: size.width * 0.2,
          child: TagWidget(
              alignmentOfContent: MainAxisAlignment.center,
              backgroundColor: Colors.transparent,
              textColorAndIcon: colorOfStateLoan(summary.idStateQuota),
              title: summary.stateLoan)),
    );
  }
}
