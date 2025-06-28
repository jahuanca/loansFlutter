import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddLoanInformationPage extends StatelessWidget {

  final AddLoanInformationController controller = AddLoanInformationController(
    getCustomersUseCase: Get.find(),
    getPaymentFrequenciesUseCase: Get.find(),
    getPaymentMethodsUseCase: Get.find(),
    validateLoanUseCase: Get.find(),
  );

  final FocusNode focusNodeCustomer = FocusNode();

  AddLoanInformationPage({super.key});

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
          appBar: appBarWidget(text: monthlyLoanString, hasArrowBack: true),
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
                      child: GetBuilder<AddLoanInformationController>(
                          id: customersIdGet,
                          builder: (controller) => DropdownMenuWidget(
                                focusNode: focusNodeCustomer,
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
                GetBuilder<AddLoanInformationController>(
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
                      flex: 2,
                      child: GetBuilder<AddLoanInformationController>(
                        id: frequenciesIdGet,
                        builder: (controller) => DropdownWidget(
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
                        id: percentageIdGet,
                        builder: (controller) => InputWidget(
                            textEditingController:
                                controller.percentageTextController,
                            onChanged: controller.onChangedPercentage,
                            hintText: percentageString,
                            label: percentageString),
                      ),
                    ),
                  ],
                ),
                GetBuilder<AddLoanInformationController>(
                  id: amountIdGet,
                  builder: (controller) => InputWidget(
                    hintText: 'Ingrese el monto',
                    label: amountString,
                    icon: const Icon(Icons.monetization_on),
                    textInputType: TextInputType.number,
                    onChanged: controller.onChangeAmount,
                  ),
                ),
                GetBuilder<AddLoanInformationController>(
                    id: ganancyIdGet,
                    builder: (controller) => InputWidget(
                          textEditingController:
                              controller.ganancyTextController,
                          hintText: ganancyString,
                          icon: const Icon(Icons.monetization_on),
                          label: 'Ganancia calculada',
                          enabled: false,
                        )),
                GetBuilder<AddLoanInformationController>(
                  id: methodsIdGet,
                  builder: (controller) => DropdownWidget(
                    hintText: 'Seleccione el método de pago',
                    label: paymentMethodString,
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
      padding: defaultPadding,
      child: ButtonWidget(
        text: continueString,
        onTap: controller.goNext,
      ),
    );
  }
}
