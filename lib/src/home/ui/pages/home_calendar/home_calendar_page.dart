import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/home_calendar_controller.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class HomeCalendarPage extends StatelessWidget {
  static const double _heightOfCard = 50;

  final HomeCalendarController controller = HomeCalendarController(
      getSummaryOfCalendarUseCase: Get.find(),
      getQuotasByDateUseCase: Get.find());

  HomeCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<HomeCalendarController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getSummaryOfCalendar,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarWidget(text: 'Calendario de cuotas'),
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
    int overduePayments =
        controller.summaryOfCalendarResponse?.overduePayments ?? defaultInt;
    int paymentsOfToday =
        controller.summaryOfCalendarResponse?.paymentsOfToday ?? defaultInt;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _card(
          size: size,
          title: 'Por semana',
          value: '$paymentsOfToday',
          color: successColor(),
          onTap: controller.goToQuotaGroupOfWeek,
        ),
        _card(
          size: size,
          title: 'Vencidos',
          value: '$overduePayments',
          color: dangerColor(),
          onTap: controller.goToQuotaGroupOfDefeated,
        ),
      ],
    );
  }

  Widget _card({
    required Size size,
    required String title,
    required String value,
    required Color color,
    required void Function()? onTap,
  }) {
    const double height = _heightOfCard / 2;

    return Padding(
      padding: defaultPadding,
      child: Container(
        alignment: Alignment.center,
        width: size.width * 0.5 - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius()),
          border: Border.all(),
        ),
        child: ListTile(
          onTap: onTap,
          minTileHeight: height,
          title: Text(title),
          trailing: Text(value),
        ),
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

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<HomeCalendarController>(
                  id: calendarIdGet,
                  builder: (controller) => Text(
                    controller.dateSelected.format(formatDate: formatOfSummary).orEmpty().toCapitalize(),
                    style: subtitleStyle,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async => controller.changeDatePicker(
                            await _showDatePicker(context: context)),
                        icon: const Icon(Icons.calendar_month_outlined)),
                    const IconButton(onPressed: null, icon: Icon(Icons.copy))
                  ],
                )
              ],
            ),
          ),
          _listDays(size: size),
          Expanded(child: _contentQuotas(size: size))
        ],
      ),
    );
  }

  Future<DateTime?> _showDatePicker({
    required BuildContext context,
  }) async {
    return await showDatePicker(
        context: context,
        initialDate: defaultDate,
        firstDate: defaultDate.subtract(halfYearDuration),
        lastDate: defaultDate.add(halfYearDuration));
  }

  Widget _listDays({
    required Size size,
  }) {
    return GetBuilder<HomeCalendarController>(
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
    final dateOfResponse = controller.dateSelected.subtract(oneDayDuration);
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
    return GetBuilder<HomeCalendarController>(
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
          itemBuilder: (context, index) => QuotaOfCalendarWidget(
            idStateQuota: controller.quotasByDate[index].idStateQuota,
            amount: controller.quotasByDate[index].amount,
            subtitle: controller.quotasByDate[index].customerName,
            detail: 'Aqui irá la direccion',
            idLoan: controller.quotasByDate[index].idLoan.orZero(),
            title: controller.quotasByDate[index].name,
            onTap: () => controller.goToQuota(index),
          ),
        ),
      ),
    );
  }
}
