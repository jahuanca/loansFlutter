import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_controller.dart';
import 'package:utils/utils.dart';

class PayQuotaPage extends StatelessWidget {
  const PayQuotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayQuotaController>(
      init: PayQuotaController(
        payQuotaUseCase: Get.find(),
      ),
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Pago de cuota', hasArrowBack: true),
        bottomNavigationBar:
            ButtonWidget(padding: const EdgeInsets.all(8.0), text: 'Pagar', onTap: controller.payQuota,),
        body: Column(
          children: [
            _cardDetail(quota: controller.quota),
            InputWidget(
              hintText: 'Elija la fecha de pago',
              label: 'Fecha de pago',
              onTap: () async {
                      DateTime? dateSelected = await showDatePicker(
                          context: context,
                          currentDate: controller.quota.dateToPay,
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 180)),
                          lastDate: DateTime.now().add(const Duration(days: 1)));
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
        ),
      ),
    );
  }

  Widget _cardDetail({
    required DashboardQuotaResponse quota,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 7,
        child: SizedBox(
            width: double.infinity,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(quota.customerName),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'S/ ${quota.amount}',
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
}
