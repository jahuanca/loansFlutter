import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_controller.dart';
import 'package:loands_flutter/src/utils/core/colors.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
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
      builder: (controller) => Scaffold(
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
    );
  }

  Widget _bottomSection() {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _itemBottomSection(
              title: 'Ganancia',
              value: controller.totalOfGanancy.formatDecimals()),
          _itemBottomSection(
              title: 'Perdida', value: controller.totalOfLoss.formatDecimals()),
          _itemBottomSection(
              title: 'Total', value: controller.total.formatDecimals())
        ],
      ),
    );
  }

  Widget _itemBottomSection({
    required String title,
    required String value,
  }) {
    TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Column(
      children: [
        Text(
          title,
          style: textStyle,
        ),
        Text('S/ $value'),
      ],
    );
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
