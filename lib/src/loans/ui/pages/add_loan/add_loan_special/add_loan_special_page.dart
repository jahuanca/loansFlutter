import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_special/add_loan_special_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddLoanSpecialPage extends StatelessWidget {
  final AddLoanSpecialController controller = AddLoanSpecialController(
    getCustomersUseCase: Get.find(),
    getPaymentFrequenciesUseCase: Get.find(),
    getPaymentMethodsUseCase: Get.find(),
  );

  AddLoanSpecialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLoanSpecialController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          controller.goBack();
        },
        child: Scaffold(
          appBar: appBarWidget(text: 'Préstamo especial', hasArrowBack: true),
          bottomNavigationBar: _bottomButtons(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<AddLoanSpecialController>(
                  id: startDayIdGet,
                  builder: (controller) => InputWidget(
                    onTap: () async {
                      DateTime? dateSelected = await showDatePicker(
                          currentDate: controller.addLoanRequest.startDate,
                          context: context,
                          firstDate: defaultDate.subtract(halfYearDuration),
                          lastDate: defaultDate.add(oneDayDuration));
                      controller.onChangedStartDate(dateSelected);
                    },
                    textEditingController: controller.startDateTextController,
                    enabled: false,
                    label: startDateString,
                    hintText: selectStartDateString,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GetBuilder<AddLoanSpecialController>(
                          id: customersIdGet,
                          builder: (controller) => DropdownMenuWidget(
                                hintText: selectTheCustomer,
                                label: customerString,
                                items: controller.customers,
                                idLabel: 'aliasOrFullName',
                                onChanged: controller.onChangedCustomer,
                              )),
                    ),
                    Expanded(
                        child: IconButtonWidget(
                            onPressed: controller.goAddCustomer,
                            iconData: Icons.add))
                  ],
                ),
                GetBuilder<AddLoanSpecialController>(
                  id: amountIdGet,
                  builder: (controller) => InputWidget(
                    hintText: 'Cantidad de cuotas',
                    label: 'Cuotas',
                    icon: const Icon(Icons.numbers),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeAmount,
                  ),
                ),
                GetBuilder<AddLoanSpecialController>(
                  id: percentageIdGet,
                  builder: (controller) => InputWidget(
                      textEditingController:
                          controller.percentageTextController,
                      onChanged: controller.onChangedPercentage,
                      textInputType: TextInputType.number,
                      hintText: 'Ingrese dias por cuota',
                      label: 'Dias por cuota'),
                ),
                GetBuilder<AddLoanSpecialController>(
                  id: amountIdGet,
                  builder: (controller) => InputWidget(
                    hintText: 'Ingrese el monto',
                    label: amountString,
                    icon: const Icon(Icons.monetization_on),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeAmount,
                  ),
                ),
                GetBuilder<AddLoanSpecialController>(
                  id: percentageIdGet,
                  builder: (controller) => InputWidget(
                      textEditingController:
                          controller.percentageTextController,
                      onChanged: controller.onChangedPercentage,
                      hintText: 'Ingrese un porcentaje',
                      label: percentageString),
                ),
                GetBuilder<AddLoanSpecialController>(
                    id: ganancyIdGet,
                    builder: (controller) => InputWidget(
                          textEditingController:
                              controller.ganancyTextController,
                          hintText: ganancyString,
                          icon: const Icon(Icons.monetization_on),
                          label: 'Ganancia calculada',
                          enabled: false,
                        )),
                GetBuilder<AddLoanSpecialController>(
                  id: methodsIdGet,
                  builder: (controller) => DropdownMenuWidget(
                    hintText: 'Seleccione el método de pago',
                    label: 'Método de pago',
                    items: controller.methods,
                    value: controller.addLoanRequest.idPaymentMethod,
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
        text: continueString,
        onTap: controller.goNext,
      ),
    );
  }
}
