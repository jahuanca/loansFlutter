import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/quota_widget.dart';
import 'package:utils/utils.dart';

class AddLoanQuotasPage extends StatelessWidget {
  AddLoanQuotasPage({super.key});

  final AddLoanQuotasController controller =  AddLoanQuotasController(
        createLoanUseCase: Get.find(),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<AddLoanQuotasController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
          bottomNavigationBar: _bottomButtons(),
          appBar: appBarWidget(text: 'Calendario', hasArrowBack: true),
          body: _detailQuotas(size: size),
          )
    );
  }

  Widget _detailQuotas({
    required Size size,
  }) {
    List<Widget> quotas = [];
    int i = 1;
    quotas.addAll(controller.quotas
        .map((e) {
          return QuotaWidget(
              value: i++,
              size: size,
              total: controller.quotas.length,
              expirationDate: e.dateToPay,
              amountQuota: e.amount,
              amortization: e.amount - e.ganancy,
              ganancy: e.ganancy,
              percentage: controller.percentage,
              paidDate: e.paidDate,
            );
        })
        .toList());

    return Column(
      children: quotas,
    );
  }

  Widget _bottomButtons() {
    return Padding(
      padding: defaultPadding,
      child: ButtonWidget(
        text: confirmString,
        onTap: controller.create,
      ),
    );
  }
}
