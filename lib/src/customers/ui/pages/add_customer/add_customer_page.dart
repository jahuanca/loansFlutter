import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_address_data/add_customer_address_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_data/add_customer_payment_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_page.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Contenedor del formulario por pasos. Cada paso es una pagina con su propio controller;
/// el PageView no se desliza con el dedo: solo se avanza con "Siguiente" (que valida el paso).
class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

  final AddCustomerController controller = Get.find<AddCustomerController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCustomerController>(
      id: pageIdGet,
      builder: (controller) => PopScope(
        canPop: controller.isFirstStep,
        onPopInvokedWithResult: (didPop, _) => controller.onPopInvoked(didPop),
        child: Scaffold(
          appBar: appBarWidget(
            text: addCustomerString,
            hasArrowBack: true,
          ),
          bottomNavigationBar: _bottomButtons(controller),
          body: Column(
            children: [
              _stepHeader(controller),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    AddCustomerPersonalDataPage(),
                    AddCustomerAddressDataPage(),
                    AddCustomerPaymentDataPage(),
                    AddCustomerManageDataPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepHeader(AddCustomerController controller) {
    final int total = controller.steps.length;
    final int position = controller.currentStep + 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paso $position de $total · ${controller.currentStepType.title}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: position / total,
            color: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons(AddCustomerController controller) {
    return Padding(
      padding: defaultPadding,
      child: Row(
        children: [
          if (!controller.isFirstStep) ...[
            Expanded(
              child: ButtonWidget(
                text: previousString,
                buttonType: ButtonTypeWidget.ghost,
                onTap: controller.goPreviousStep,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: ButtonWidget(
              text: controller.isLastStep ? confirmString : nextString,
              onTap: controller.goNextStep,
            ),
          ),
        ],
      ),
    );
  }
}
