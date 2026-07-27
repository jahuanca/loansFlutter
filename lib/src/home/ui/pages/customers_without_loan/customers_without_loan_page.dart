import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:loands_flutter/src/home/ui/pages/customers_without_loan/customers_without_loan_controller.dart';
import 'package:loands_flutter/src/utils/ui/pages/routes_app.dart';
import 'package:utils/utils.dart';

class CustomersWithoutLoanPage extends StatelessWidget {
  final CustomersWithoutLoanController controller =
      CustomersWithoutLoanController(getCustomerWithoutLoanUseCase: Get.find());

  CustomersWithoutLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersWithoutLoanController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getCustomers,
        child: Scaffold(
          appBar: appBarWidget(text: 'Clientes sin crédito'),
          body: ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(controller.customers[index].aliasOrFullName),
              trailing: IconButtonWidget(
                  onPressed: () => RoutesApp.goCustomerAnalytics(
                      customerSelected: controller.customers[index]),
                  backgroundColor: infoColor(),
                  iconData: Icons.analytics),
            ),
          ),
        ),
      ),
    );
  }
}
