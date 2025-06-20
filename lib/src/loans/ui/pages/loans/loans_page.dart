import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_controller.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
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
        child: Scaffold(
          appBar: _appBar(),
          floatingActionButton: _floatingActionButton(),
          body: _body(size),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return appBarWidget(text: 'Créditos', hasArrowBack: true, actions: [
      const IconWidget(
          padding: defaultPadding, iconData: Icons.filter_alt_outlined),
      const IconWidget(padding: defaultPadding, iconData: Icons.search),
    ]);
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.goToAddLoanInformation,
      child: const Icon(Icons.add),
    );
  }

  Widget _body(Size size) {
    return ChildOrElseWidget(
      condition: controller.loans.isNotEmpty,
      elseWidget: EmptyWidget(),
      child: _list(size),
    );
  }

  Widget _list(Size size) {
    return ListView.builder(
      itemCount: controller.loans.length,
      itemBuilder: (context, index) => _item(
        size: size,
        loan: controller.loans[index],
      ),
    );
  }

  Widget _item({
    required Size size,
    required LoanEntity loan,
  }) {
    return ListTile(
      onTap: () => controller.goToDetail(loan),
      leading: Text('${loan.id}'),
      title: _titleItem(loan),
      subtitle: Text(loan.customerEntity?.aliasOrFullName ?? emptyString),
      trailing: Text(loan.startDate.formatDMMYYY() ?? emptyString),
    );
  }

  Widget _titleItem(LoanEntity loan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(loan.formatTitle),
        if (loan.idStateLoan == idOfCompleteLoan) 
        _iconComplete()
      ],
    );
  }

  Widget _iconComplete() => IconWidget(
      padding: const EdgeInsets.only(left: 8.0),
      color: successColor(),
      iconData: Icons.check);
}
