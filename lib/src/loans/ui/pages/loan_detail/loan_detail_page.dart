import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_controller.dart';
import 'package:loands_flutter/src/utils/ui/widgets/quota_widget.dart';
import 'package:utils/utils.dart';

class LoanDetailPage extends StatelessWidget {
  LoanDetailPage({super.key});
  final LoanDetailController controller = Get.find<LoanDetailController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GetBuilder<LoanDetailController>(
      init: controller,
      builder: (controller) => Scaffold(
        bottomNavigationBar: GetBuilder<LoanDetailController>(
          id: 'quotas',
          builder: (controller) =>ChildOrElseWidget(
              condition: controller.quotas.any((e) => e.idStateQuota == 1,), 
              child: ButtonWidget(
              padding: const EdgeInsets.all(8.0),
              text: 'Pagar cuota')
              
          ),
        ),
        appBar: appBarWidget(
            hasArrowBack: true,
            text: 'Préstamo ${controller.loanSelected?.id}'),
        body: ListView(
          children: [
            if (controller.loanSelected != null)
              _detailLoan(
                size: size,
                loan: controller.loanSelected!,
              ),
            GetBuilder<LoanDetailController>(
              id: 'quotas',
              builder: (controller) => _detailQuotas(
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailLoan({
    required Size size,
    required LoanEntity loan,
  }) {
    final CustomerEntity? customer = loan.customerEntity;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: CircleAvatar(
            radius: 48,
          ),
        ),
        Text(
          '${customer?.fullName}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor().withAlpha(100),
                ),
                borderRadius: BorderRadius.circular(borderRadius())),
            height: 120,
            width: size.width,
            child: Row(
              children: [
                _itemLoan(
                  label: 'Monto',
                  value: 'S/ ${loan.amount.formatDecimals()}',
                ),
                _itemLoan(
                  label: 'Porcentaje',
                  value: '${loan.percentage.formatDecimals()}%',
                ),
                _itemLoan(
                  label: 'Fecha',
                  value: loan.date.formatDMMYYY()!,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemLoan({
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _detailQuotas({
    required Size size,
  }) {
    List<Widget> quotas = [];
    quotas.add(
      const Text('Cuotas: '),
    );
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
              percentage: controller.loanSelected?.percentage ?? defaultDouble,
            );
        })
        .toList());

    return Column(
      children: quotas,
    );
  }
}
