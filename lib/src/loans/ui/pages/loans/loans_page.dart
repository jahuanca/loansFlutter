import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_controller.dart';
import 'package:utils/utils.dart';

class LoansPage extends StatelessWidget {
  LoansPage({super.key});

  final LoansController controller = LoansController(
    getLoansUseCase: Get.find(),
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<LoansController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getLoans,
        child: Stack(
          children: [
            Scaffold(
              appBar: appBarWidget(
                text: 'Créditos',
                hasArrowBack: true,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: controller.goToAddLoanInformation,
                child: const Icon(Icons.add),
              ),
              body: ListView.builder(
                itemCount: controller.loans.length,
                itemBuilder: (context, index) => _item(
                  size: size,
                  loan: controller.loans[index],
                ),
              ),
            ),
            GetBuilder<LoansController>(
              id: validandoIdGet,
              builder: (controller) => LoadingWidget(show: controller.validando))
          ],
        ),
      ),
    );
  }

  Widget _item({
    required Size size,
    required LoanEntity loan,
  }) {
    return ListTile(
      onTap: ()=> controller.goToDetail(loan),
      leading: Text('${loan.id}'),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(loan.formatTitle),
          if(loan.idStateLoan == 2)
          IconWidget(
            padding: const EdgeInsets.only(left: 8.0),
            color: successColor(),
            iconData: Icons.check)
        ],
      ),
      subtitle: Text(loan.customerEntity?.aliasOrFullName ?? emptyString),
      trailing: Text(loan.date.formatDMMYYY() ?? emptyString),
    );
  }
}
