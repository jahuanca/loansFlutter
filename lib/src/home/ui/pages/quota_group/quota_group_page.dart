import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/quota_group_controller.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class QuotaGroupPage extends StatelessWidget {
  final QuotaGroupController controller = QuotaGroupController(
    getQuotasByDateUseCase: Get.find(),
  );

  QuotaGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotaGroupController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getQuotas,
        child: Scaffold(
          appBar: appBarWidget(text: controller.title, actions: [
            ChildOrElseWidget(
              condition: controller.isGroup,
              child: IconWidget(
                padding: defaultPadding,
                onTap: _showDatePickerRange,
                iconData: Icons.calendar_month_outlined,
              ),
            ),
            MenuOverlayWidget(
              iconData: Icons.more_vert,
              padding: defaultPadding,
              items: [
                //TODO: crear un enum y que el enums tambien
                //puedan ser pasados al MenuOverlay
                OptionMenu(id: 1, name: 'Filtrar'),
                OptionMenu(id: 2, name: 'Copiar'),
                OptionMenu(id: 3, name: 'Configurar'),
              ],
              onTapItem: controller.onChangedMenuOverlay,
            ),
          ]),
          body: ChildOrElseWidget(
              condition: controller.quotas.isNotEmpty, child: _listOfContent()),
        ),
      ),
    );
  }

  Widget _listOfContent() {
    return (controller.isGroup) ? _listOfGroup() : _listOfCalendar();
  }

  Widget _listOfCalendar() {
    return ListView.builder(
      itemCount: controller.quotas.length,
      itemBuilder: (context, index) =>
          _itemOfCalendar(controller.quotas[index]),
    );
  }

  Widget _listOfGroup() {
    return ListView.builder(
      itemCount: controller.groupByDate.values.length,
      itemBuilder: (context, index) => _itemOfGroup(index),
    );
  }

  Widget _itemOfGroup(int index) {
    List<Map<String, dynamic>> group =
        controller.groupByDate.values.elementAt(index);
    String key = controller.groupByDate.keys.elementAt(index);
    DateTime dateOfTitle = DateTime.parse(key);
    String title = dateOfTitle
        .format(formatDate: formatOfSummary)
        .orEmpty()
        .toCapitalize();

    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);
    int quantityOfPendings = 0;
    List<Widget> items = group.map((e) {
      DashboardQuotaResponse quota = DashboardQuotaResponse.fromJson(e);
      if (quota.idStateQuota == idOfPendingQuota) {
        quantityOfPendings++;
      }
      return _itemOfCalendar(quota);
    }).toList();

    Widget titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        if (quantityOfPendings > defaultInt)
          CircleAvatar(
              backgroundColor: dangerColor(),
              radius: 12,
              child: Text(quantityOfPendings.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white))),
      ],
    );

    return ExpansionTile(
      title: titleWidget,
      initiallyExpanded: (quantityOfPendings > defaultInt),
      children: items,
    );
  }

  Widget _itemOfCalendar(DashboardQuotaResponse quota) {
    return QuotaOfCalendarWidget(
      idStateQuota: quota.idStateQuota,
      amount: quota.amount,
      subtitle: quota.aliasOrName,
      detail: quota.dateToPay.formatDMMYYY().orEmpty(),
      idLoan: quota.idLoan.orZero(),
      title: quota.name,
      onTap: () => controller.goToQuota(quota.id),
    );
  }

  Future<void> _showDatePickerRange() async {
    DateTimeRange? range = await showDateRangePicker(
      initialDateRange: controller.dateTimeRange,
      context: Get.context!,
      firstDate: defaultDate.subtract(halfYearDuration),
      lastDate: defaultDate.add(halfYearDuration),
    );
    controller.onChangedDateTimeRange(range);
  }
}
