import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/text/subtitle_widget.dart';
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
                if (controller.isPending) _form(context),
                _content(),
                if (controller.isPending.not()) _paidQuotaWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    DashboardQuotaResponse quota = controller.quota!;
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleWidget(
            padding: defaultPadding,
            text: (controller.isPending) ? 'Cuota a pagar:' : 'Cuota pagada',),
          Padding(
            padding: defaultPadding,
            child: ChildOrElseWidget(
                condition: (controller.quota != null),
                child: QuotaOfCalendarWidget(
                  amount: quota.amount,
                  subtitle: quota.customerName,
                  idLoan: quota.idLoan.orZero(),
                  title: quota.name,
                )),
          ),
        ],
      ),
    );
  }

  Widget _paidQuotaWidget() {
    return GestureDetector(
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
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        InputWidget(
          hintText: pickPayDateString,
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

  Widget _bottomNavigation() {
    return ChildOrElseWidget(
      condition: (controller.isPending),
      child: _buttomsNavigation(),
    );
  }

  Widget _buttomsNavigation() {
    final String payToText =
        '$payString  S/${controller.quota?.amount.formatDecimals()}';

    return Row(
      children: [
        Expanded(
            child: ButtonWidget(
          padding: defaultPadding,
          text: payToText,
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
