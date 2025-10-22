import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_renewal/add_renewal_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddRenewalPage extends StatelessWidget {
  final AddRenewalController controller = AddRenewalController(
    getCustomersUseCase: Get.find(),
    getMetadataRenewalUseCase: Get.find(),
    addRenewalUseCase: Get.find(),
  );

  AddRenewalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRenewalController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.goRefresh,
        child: Scaffold(
          appBar: appBarWidget(text: 'Vincular renovación'),
          bottomNavigationBar: _bottomNavigation(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                DropdownMenuWidget(
                  controller: controller.customerTextController,
                  initialValue: controller.customerSelected?.id,
                  items: controller.customers.map((e) => e.toDropdown()).toList(),
                  idLabel: 'aliasOrFullName',
                  hintText: selectTheCustomer,
                  label: customerString,
                  onChanged: controller.onChangedCustomer,
                ),
                GetBuilder<AddRenewalController>(
                  id: 'loans_new',
                  builder: (controller) => DropdownMenuWidget(
                    controller: controller.newLoanTextController,
                    initialValue: controller.newLoanSelected?.id,
                    items:
                        controller.loansNew.map((e) => e.toJson()).toList(),
                    label: 'Préstamo nuevo',
                    hintText: 'Préstamo nuevo',
                    onChanged: controller.onChangedNewLoan,
                  ),
                ),
                GetBuilder<AddRenewalController>(
                  id: 'loans_previous',
                  builder: (controller) => DropdownMenuWidget(
                    controller: controller.previousLoanTextController,
                    initialValue: controller.previousLoanSelected?.id,
                    items:
                        controller.loansPrevious.map((e) => e.toJson()).toList(),
                    label: 'Préstamo anterior',
                    hintText: 'Préstamo anterior',
                    onChanged: controller.onChangedPreviousLoan,
                  ),
                ),
                InputWidget(
                    label: 'Fecha de renovación',
                    textEditingController: controller.renewalDateTextController,
                    enabled: false,
                    hintText: 'Fecha de renovación'),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: InputWidget(
        
                          textEditingController: controller.typeRenewalTextController,
                          label: 'Tipo',
                          enabled: false,
                          hintText: 'Tipo')),
                    Flexible(
                      flex: 2,
                        child: InputWidget(
                            textEditingController:
                                controller.variationTextController,
                            enabled: false,
                            label: 'Variación',
                            hintText: 'Variación en monto')),
                  ],
                ),
                InputWidget(
                    label: 'Observación',
                    hintText: 'Observación')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      padding: defaultPadding,
      child: ButtonWidget(
        onTap: controller.goCreate,
        text: 'Vincular'),
    );
  }
}
