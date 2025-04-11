import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_home/add_loan_home_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_page.dart';
import 'package:utils/utils.dart';

class AddLoanHomePage extends StatelessWidget {
  AddLoanHomePage({super.key});

  final AddLoanHomeController controller = Get.find<AddLoanHomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLoanHomeController>(
      init: Get.find<AddLoanHomeController>(),
      id: pageIdGet,
      builder: (controller) => Stack(
        children: [
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              controller.goBack();
            },
            child: Scaffold(
              appBar: appBarWidget(text: 'Crear crédito', hasArrowBack: true),
              body: PageView(
                controller: controller.pageController,
                pageSnapping: false,
                children: [
                  AddLoanInformationPage(),
                  AddLoanQuotasPage(),
                ],
              ),
              bottomNavigationBar: _bottomButtons(),
            ),
          ),
          GetBuilder<AddLoanHomeController>(
            id: validandoIdGet,
            builder: (controller) => LoadingWidget(show: controller.validando),
          ),
        ],
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
