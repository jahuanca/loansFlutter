import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/next_renewal/next_renewal_controller.dart';
import 'package:loands_flutter/src/loans/ui/widgets/options_menu_widget.dart';
import 'package:utils/utils.dart';

class NextRenewalPage extends StatelessWidget {
  const NextRenewalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NextRenewalController>(
      id: pageIdGet,
      init: NextRenewalController(
        getNextRenewalUseCase: Get.find(),
      ),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(
          text: 'Próximos a vencer',
          actions: [
            OptionsMenuWidget(onTapItem: controller.onChangedMenuOverlay),
          ]
          ),
        body: ListView.builder(
          itemCount: controller.quotas.length,
          itemBuilder: (context, index) =>
              _itemRenewal(controller.quotas[index]),
        ),
      ),
    );
  }

  Widget _itemRenewal(DashboardQuotaResponse quota) {
    String detail = 'S/ ${quota.amountOfLoan?.formatDecimals()} - ${quota.dateToPay.formatDMMYYY()}';

    return QuotaOfCalendarWidget(
      idLoan: quota.idLoan,
      title: quota.name,
      subtitle: quota.customerName,
      amount: quota.amount,
      idStateQuota: quota.idStateQuota,
      detail: detail,
    );
  }
}
