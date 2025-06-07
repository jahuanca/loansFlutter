import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
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
    return SizedBox(
      height: size.height * 0.15,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _card(
              size: size,
              icon: Icons.numbers,
              title: 'Créditos',
              mount: controller.dashboardSummaryResponse?.loansCount.toString(),
              onTap: controller.goToLoans),
          _card(
            size: size,
            icon: Icons.monetization_on,
            title: 'Total prestado',
            mount:
                controller.dashboardSummaryResponse?.allAmount.formatDecimals(),
          ),
          _card(
            size: size,
            icon: Icons.upload_rounded,
            title: 'Ganancia',
            mount: controller.dashboardSummaryResponse?.allGanancy
                .formatDecimals(),
          ),
          _card(
            size: size,
            icon: Icons.people,
            title: 'Clientes',
            mount:
                controller.dashboardSummaryResponse?.customersCount.toString(),
            onTap: controller.goToCustomers,
          ),
        ],
      ),
    );
  }

  Widget _card({
    required IconData icon,
    required String title,
    required String? mount,
    required Size size,
    void Function()? onTap,
  }) {
    const TextStyle amountStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width * 0.4,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey.withAlpha(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(icon),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    mount ?? emptyString,
                    style: amountStyle,
                  ),
                ],
              ),
              Text(title),
            ],
          ),
        ),
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
            padding: const EdgeInsets.all(8.0),
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
          itemBuilder: (context, index) => _itemDay(day: index, context: context),
        ),
      ),
    );
  }

  Widget _itemDay({
    required int day,
    required BuildContext context,
  }) {
    final dateOfResponse = controller.dashboardSummaryResponse?.dateToSearch ?? defaultDate;
    final date = dateOfResponse.add(Duration(days: day));
    final isSelected = (date.formatDMMYYY() == controller.dateSelected.formatDMMYYY());
    final TextStyle textStyle = TextStyle(
                        color: isSelected ? Colors.white : Colors.black
                      );

    return Container(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () => controller.getQuotasByDay(date),
        child: Card(
          color: isSelected ? successColor() : CardTheme.of(context).color,
          child: Container(
            padding: const EdgeInsets.all(8.0),
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
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => controller.goToQuota(quota),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius()),
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(8.0),
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
