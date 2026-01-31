import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota_multiple/pay_quota_multiple_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/text/subtitle_widget.dart';
import 'package:utils/utils.dart';

class PayQuotaMultiplePage extends StatelessWidget {
  final PayQuotaMultipleController controller = PayQuotaMultipleController(
    payQuotaUseCase: Get.find(),
  );

  PayQuotaMultiplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<PayQuotaMultipleController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Scaffold(
            appBar: appBarWidget(text: 'Pago múltiple', hasArrowBack: true),
            bottomNavigationBar: _bottomNavigation(),
            body: ListView(
              children: [
                if (controller.isPending) _form(context),
                _summary(),
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
    final List<Widget> items = [];

    items.add(SubtitleWidget(
          text: (controller.isPending) ? 'Cuotas a pagar: ' : 'Cuotas pagadas',
          padding: defaultPadding)
    );

    for (var i = 0; i < controller.quotas.length; i++) {
      final quota = controller.quotas[i];
      items.add(QuotaOfCalendarWidget(
        amount: quota.amount,
        subtitle: quota.customerName,
        idLoan: quota.idLoan.orZero(),
        title: quota.name,
      ));
    }

    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
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
          onTap: null,
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
          hintText: pickPayDateString,
          label: paymentDateString,
          onTap: () async {
            DateTime? dateSelected = await showDatePicker(
                context: context,
                // currentDate: controller.quota?.dateToPay,
                // TODO: aqui deberia crear un switch para que el usuario
                // ponga la fecha en que se vencieron o ponga una fecha unica para todos.
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

  Widget _summary() {
    return const Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleWidget(text: 'Resumen', padding: defaultPadding),
          SubtitleWidget(text: 's/ 450 s/25 s/mio', padding: defaultPadding),
        ],
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
    return ButtonWidget(
      padding: defaultPadding,
      text: payString,
      onTap: controller.goPayQuota,
    );
  }
}
