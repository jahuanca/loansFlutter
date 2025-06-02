import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_controller.dart';
import 'package:utils/utils.dart';

class AddLoanInformationPage extends StatelessWidget {
  AddLoanInformationPage({super.key});

  final AddLoanInformationController controller =
      AddLoanInformationController(
        getCustomersUseCase: Get.find(),
        getPaymentFrequenciesUseCase: Get.find(),
        getPaymentMethodsUseCase: Get.find(),
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLoanInformationController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          controller.goBack();
        },
        child: Scaffold(
          appBar: appBarWidget(text: 'Agregar prestamo', hasArrowBack: true),
          bottomNavigationBar: _bottomButtons(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                GetBuilder<AddLoanInformationController>(
                  id: 'start_day',
                  builder: (controller) => InputWidget(
                    onTap: () async {
                      DateTime? dateSelected = await showDatePicker(
                          context: context,
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 180)),
                          lastDate: DateTime.now().add(const Duration(days: 1)));
                      controller.onChangedStartDate(dateSelected);
                    },
                    textEditingController: controller.startDateTextController,
                    enabled: false,
                    label: 'Fecha de inicio',
                    hintText: 'Fecha de inicio',
                  ),
                ),
                GetBuilder<AddLoanInformationController>(
                  id: 'customers',
                    builder: (controller) => DropdownMenuWidget(
                          hintText: 'Seleccione el cliente',
                          label: 'Cliente',
                          items: controller.customers,
                          idLabel: 'fullName',
                          onChanged: controller.onChangedCustomer,
                        )),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GetBuilder<AddLoanInformationController>(
                        id: 'frequencies',
                        builder: (controller) => DropdownMenuWidget(
                          hintText: 'Seleccione la frecuencia',
                          label: 'Frecuencia de pago',
                          items: controller.frequencies,
                          idLabel: 'titleItem',
                          onChanged: controller.onChangedFrequency,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GetBuilder<AddLoanInformationController>(
                        id: 'percentage',
                        builder: (controller) => InputWidget(
                            textEditingController:
                                controller.percentageTextController,
                                onChanged: controller.onChangedPercentage,
                            hintText: 'Porcentaje',
                            label: 'Porcentaje'),
                      ),
                    ),
                  ],
                ),
                GetBuilder<AddLoanInformationController>(
                  id: 'amount',
                  builder: (controller) => InputWidget(
                    hintText: 'Ingrese el monto',
                    label: 'Monto',
                    icon: const Icon(Icons.monetization_on),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeAmount,
                  ),
                ),
                GetBuilder<AddLoanInformationController>(
                    id: 'ganancy',
                    builder: (controller) => InputWidget(
                          textEditingController: controller.ganancyTextController,
                          hintText: 'Ganancia',
                          icon: const Icon(Icons.monetization_on),
                          label: 'Ganancia calculada',
                          enabled: false,
                        )),
                GetBuilder<AddLoanInformationController>(
                  id: 'methods',
                  builder: (controller) => DropdownMenuWidget(
                    hintText: 'Seleccione el método de pago',
                    label: 'Método de pago',
                    items: controller.methods,
                    idLabel: 'name',
                    onChanged: controller.onChangedMethodsPayment,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonWidget(
        text: 'Continuar',
        onTap: controller.goNext,
      ),
    );
  }
}
