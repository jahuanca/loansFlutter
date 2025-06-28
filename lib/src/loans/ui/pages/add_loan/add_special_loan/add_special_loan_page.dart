import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_special_loan/add_special_loan_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanPage extends StatelessWidget {
  final AddSpecialLoanController controller = AddSpecialLoanController(
    getCustomersUseCase: Get.find(),
    getPaymentFrequenciesUseCase: Get.find(),
    getPaymentMethodsUseCase: Get.find(),
    validateLoanUseCase: Get.find(),
  );

  final FocusNode customerFocusNode = FocusNode();

  AddSpecialLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSpecialLoanController>(
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
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GetBuilder<AddSpecialLoanController>(
                          id: customersIdGet,
                          builder: (controller) => DropdownMenuWidget(
                                focusNode: customerFocusNode,
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
                GetBuilder<AddSpecialLoanController>(
                  id: startDayIdGet,
                  builder: (controller) => InputWidget(
                    onTap: () async {
                      DateTime? dateSelected = await showDatePicker(
                          currentDate:
                              controller.addSpecialLoanRequest.startDate,
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
                GetBuilder<AddSpecialLoanController>(
                  id: numberOfInstallmentsIdGet,
                  builder: (controller) => InputWidget(
                    hintText: 'Número de cuotas',
                    label: 'Cuotas',
                    icon: const Icon(Icons.numbers),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeNumberOfInstallments,
                  ),
                ),
                GetBuilder<AddSpecialLoanController>(
                  id: daysBetweenInstallmentsIdGet,
                  builder: (controller) => InputWidget(
                      onChanged: controller.onChangeDaysBetweenInstallments,
                      textInputType: TextInputType.number,
                      hintText: 'Ingrese dias por cuota',
                      label: 'Dias por cuota'),
                ),
                GetBuilder<AddSpecialLoanController>(
                  id: amountIdGet,
                  builder: (controller) => InputWidget(
                    hintText: 'Ingrese el monto',
                    label: amountString,
                    icon: const Icon(Icons.monetization_on),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeAmount,
                  ),
                ),
                GetBuilder<AddSpecialLoanController>(
                  id: percentageIdGet,
                  builder: (controller) => InputWidget(
                      onChanged: controller.onChangedPercentage,
                      hintText: 'Ingrese un porcentaje',
                      label: percentageString),
                ),
                GetBuilder<AddSpecialLoanController>(
                    id: ganancyIdGet,
                    builder: (controller) => InputWidget(
                          textEditingController:
                              controller.ganancyTextController,
                          hintText: ganancyString,
                          icon: const Icon(Icons.monetization_on),
                          label: 'Ganancia calculada',
                          enabled: false,
                        )),
                GetBuilder<AddSpecialLoanController>(
                  id: methodsIdGet,
                  builder: (controller) => DropdownWidget(
                    hintText: 'Seleccione el método de pago',
                    label: paymentMethodString,
                    items: controller.methods,
                    value: controller.addSpecialLoanRequest.idPaymentMethod,
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
      padding: defaultPadding,
      child: ButtonWidget(
        text: continueString,
        onTap: controller.goNext,
      ),
    );
  }
}
