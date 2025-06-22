import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_summary_response.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/widgets/card_dasboard_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/widgets/card_single_dasboard_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<DashboardController>(
      id: pageIdGet,
      init: Get.find<DashboardController>(),
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getSummary,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarWidget(text: 'Inicio'),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                _cards(size: size),
                _details(size: size),
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

    DashboardSummaryResponse? response = controller.dashboardSummaryResponse;

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
              onTap: controller.goToLoans),
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
          cardSingleDashboardWidget(
            size: size,
            icon: Icons.people,
            title: customersString,
            value:
                controller.dashboardSummaryResponse?.customersCount.toString(),
            onTap: controller.goToCustomers,
          ),
        ],
      ),
    );
  }

  Widget _details({
    required Size size,
  }) {
    const TextStyle subtitleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: defaultPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pagos pendientes',
                  style: subtitleStyle,
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
          _listDays(size: size),
          Expanded(child: _contentQuotas(size: size))
        ],
      ),
    );
  }

  Widget _listDays({
    required Size size,
  }) {
    return GetBuilder<DashboardController>(
      id: calendarIdGet,
      builder: (controller) => SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 30,
          itemBuilder: (context, index) =>
              _itemDay(day: index, context: context),
        ),
      ),
    );
  }

  Widget _itemDay({
    required int day,
    required BuildContext context,
  }) {
    final dateOfResponse =
        controller.dashboardSummaryResponse?.dateToSearch ?? defaultDate;
    final date = dateOfResponse.add(Duration(days: day));
    final isSelected =
        (date.formatDMMYYY() == controller.dateSelected.formatDMMYYY());
    final TextStyle textStyle =
        TextStyle(color: isSelected ? Colors.white : Colors.black);

    return Container(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () => controller.getQuotasByDay(date),
        child: Card(
          color: isSelected ? successColor() : CardTheme.of(context).color,
          child: Container(
            padding: defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date
                      .format(formatDate: 'MMMM')
                      .orEmpty()
                      .capitalizeFirst
                      .toString(),
                  style: textStyle,
                ),
                Text(
                  date.day.toString(),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentQuotas({required Size size}) {
    return GetBuilder<DashboardController>(
      id: quotasIdGet,
      builder: (controller) => ChildOrElseWidget(
        condition: controller.quotasByDate.isNotEmpty,
        elseWidget: Container(
          alignment: Alignment.center,
          height: 200,
          child: const Text('No se encontraron cuotas'),
        ),
        child: ListView.builder(
          itemCount: controller.quotasByDate.length,
          itemBuilder: (context, index) => _itemQuota(
            index: index,
            quota: controller.quotasByDate[index],
          ),
        ),
      ),
    );
  }

  Widget _itemQuota({
    required int index,
    required DashboardQuotaResponse quota,
  }) {
    String name = quota.name;
    String amountValue = quota.amount.formatDecimals();
    String nameStateQuota = quota.stateQuota['name'];
    Color colorStateQuota = quota.stateQuota['color'];

    return Padding(
      padding: defaultPadding,
      child: GestureDetector(
        onTap: () => controller.goToQuota(quota),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius()),
            border: Border.all(),
          ),
          padding: defaultPadding,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(
                      text: 'S/ ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: amountValue,
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(quota.customerName),
                    const Text('Direccion del deudor'),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: TagWidget(
                      alignmentOfContent: MainAxisAlignment.center,
                      backgroundColor: colorStateQuota,
                      textColorAndIcon: Colors.white,
                      title: nameStateQuota)),
            ],
          ),
        ),
      ),
    );
  }
}
