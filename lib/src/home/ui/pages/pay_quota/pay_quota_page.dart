import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class PayQuotaPage extends StatelessWidget {
  final PayQuotaController controller =
      PayQuotaController(payQuotaUseCase: Get.find());

  PayQuotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<PayQuotaController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Scaffold(
            appBar: appBarWidget(
                text: '#P${controller.quota?.idLoan}: Pago de cuota',
                hasArrowBack: true),
            bottomNavigationBar: _bottomNavigation(),
            body: ListView(
              children: [
                ChildOrElseWidget(
                    condition: (controller.quota != null),
                    child: _cardDetail(size: size, quota: controller.quota!)),
                ChildOrElseWidget(
                    condition: (controller.isPending),
                    elseWidget: _paidQuotaWidget(),
                    child: _form(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _paidQuotaWidget() {
    return Column(
      children: [
        EmptyWidget(
          iconData: Icons.check,
          title: 'Esta cuota ya ha sido pagada.',
        ),
        GestureDetector(
          onTap: controller.copyPaidQuota,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconWidget(
                  padding: EdgeInsets.only(
                    top: 64,
                    bottom: 8,
                  ),
                  iconData: Icons.copy_outlined),
              Text('Copiar información de pago')
            ],
          ),
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        InputWidget(
          hintText: 'Seleccione la fecha de pago',
          label: paymentDateString,
          onTap: () async {
            DateTime? dateSelected = await showDatePicker(
                context: context,
                currentDate: controller.quota?.dateToPay,
                firstDate: defaultDate.subtract(halfYearDuration),
                lastDate: defaultDate.add(oneDayDuration));
            controller.onChangedStartDate(dateSelected);
          },
          textEditingController: controller.dateToPayTextController,
          enabled: false,
        ),
        InputWidget(
          hintText: 'Evidencia',
          label: 'Evidencia',
        ),
      ],
    );
  }

  Widget _cardDetail({
    required DashboardQuotaResponse quota,
    required Size size,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 7,
        child: SizedBox(
            width: size.width,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(quota.customerName),
                Text(
                  quota.alias.orEmpty(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12),
                ),
                Padding(
                  padding: defaultPadding,
                  child: Text(
                    'S/ ${quota.amount.formatDecimals()}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Cuota: ${quota.name} - ${quota.dateToPay.formatDMMYYY()}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _bottomNavigation() {
    return ChildOrElseWidget(
      condition: (controller.isPending),
      child: _buttomsNavigation(),
    );
  }

  Widget _buttomsNavigation() {
    return Row(
      children: [
        Expanded(
            child: ButtonWidget(
          padding: defaultPadding,
          text: 'Pagar',
          onTap: controller.goPayQuota,
        )),
        if (controller.isLastQuota)
        Expanded(
            child: ButtonWidget(
          padding: defaultPadding,
          text: 'Pagar y renovar',
          buttonStyle: ButtonStyleWidget.success,
          onTap: controller.goPayQuotaAndRenewLoan,
        )),
      ],
    );
  }
}
