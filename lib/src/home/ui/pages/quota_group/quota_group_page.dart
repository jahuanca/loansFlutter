import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/quota_group_controller.dart';
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
            MenuOverlayWidget(
              //TODO: copiar cuotas de ese día.
              // agrupar por dias las cuotas. (puede ser en un lisTile) y que cada
              // grupo se pueda copiar.
              iconData: Icons.more_vert,
              padding: defaultPadding,
              items: const [
                {
                  'id': 1,
                  'name': 'Filtrar',
                },
                {
                  'id': 2,
                  'name': 'Copiar',
                },
                {
                  'id': 3,
                  'name': 'Refrescar',
                },
              ],
              onTapItem: (e) => {},
            ),
          ]),
          body: ChildOrElseWidget(
              condition: controller.quotas.isNotEmpty, child: _listOfContent()),
        ),
      ),
    );
  }

  Widget _listOfContent() {
    return (controller.isGroup) ? _listOfGroup() :  _listOfCalendar();
  }

  Widget _listOfCalendar() {
    return ListView.builder(
      itemCount: controller.quotas.length,
      itemBuilder: (context, index) => _itemOfCalendar(controller.quotas[index]),
    );
  }

  Widget _listOfGroup() {
    return ListView.builder(
      itemCount: controller.groupByDate.values.length,
      itemBuilder: (context, index) => _itemOfGroup(index),
    );
  }

  Widget _itemOfGroup(int index) {
    List<Map<String, dynamic>> group = controller.groupByDate.values.elementAt(index);
    String key = controller.groupByDate.keys.elementAt(index);
    DateTime dateOfTitle = DateTime.parse(key);
    String title = dateOfTitle.format(formatDate: formatOfSummary).orEmpty().toCapitalize();

    List<Widget> items = group.map(
      (e) => _itemOfCalendar(
        DashboardQuotaResponse.fromJson(e)
      )
    ).toList();

    return ExpansionTile(
      title: Text(title),
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
}
