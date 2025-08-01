import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/card_dasboard_widget.dart';
import 'package:loands_flutter/src/home/ui/widgets/item_activity_widget.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = DashboardController(
    getLogsUseCase: Get.find(),
    getQuotasByDateUseCase: Get.find(),
    getSummaryDasboardUseCase: Get.find(),
  );

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<DashboardController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getAll,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarWidget(text: 'Inicio'),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                _cards(size: size),
                _details(size: size, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cards({
    required Size size,
  }) {
    const double heightOfCard = 150;

    SummaryOfDashboardResponse? response =
        controller.summaryOfDashboardResponse;

    Map<String, dynamic> valuesOfLoans = response?.loansInfo ?? {};

    Map<String, dynamic> valuesOfAmount = response?.amountsInfo ?? {};

    Map<String, dynamic> valuesOfGanancy = response?.ganancyInfo ?? {};

    return SizedBox(
      height: heightOfCard,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          cardDashboardWidget(
              size: size,
              title: 'Créditos',
              values: valuesOfLoans,
              onTap: null),
          cardDashboardWidget(
              size: size,
              title: 'Total prestado',
              values: valuesOfAmount,
              onTap: controller.goToPaymentSummary),
          cardDashboardWidget(
            size: size,
            title: ganancyString,
            values: valuesOfGanancy,
          ),
        ],
      ),
    );
  }

  Widget _details({
    required Size size,
    required BuildContext context,
  }) {
    const TextStyle subtitleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Actividad',
            style: subtitleStyle,
          ),
        ),
        SizedBox(
          height: size.height * 0.5,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.logs.length,
            itemBuilder: (context, index) => ItemActivityWidget(log: controller.logs[index]),
          ),
        ),
      ],
    );
  }
}
