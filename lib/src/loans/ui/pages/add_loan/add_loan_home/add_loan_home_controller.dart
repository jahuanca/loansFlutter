import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_controller.dart';
import 'package:utils/utils.dart';

class AddLoanHomeController extends GetxController {
  int indexPage = defaultInt;
  PageController pageController = PageController();
  CreateLoanUseCase createLoanUseCase;
  late AddLoanRequest addLoanRequest;
  bool validando = false;

  AddLoanHomeController({
    required this.createLoanUseCase,
  });

  AddLoanInformationController? get _informationController =>
      Get.find<AddLoanInformationController>();

  void goNext() async {
    switch (indexPage) {
      case 0:
        ValidateResult resultInformation = _informationController!.validate();
        if (resultInformation.hasError) {
          showSnackbarWidget(
              context: Get.overlayContext!,
              typeSnackbar: TypeSnackbar.error,
              message: resultInformation.error ?? emptyString);
          return;
        }
        addLoanRequest = resultInformation.value as AddLoanRequest;
        Get.find<AddLoanQuotasController>().setLoanRequest(addLoanRequest);
        break;
      case 1:
        validando = true;
        update([validandoIdGet]);
        ResultType<LoanEntity, ErrorEntity> resultType =
            await createLoanUseCase.execute(addLoanRequest);
        if (resultType is Error) {
          showSnackbarWidget(
              context: Get.overlayContext!,
              typeSnackbar: TypeSnackbar.error,
              message: resultType.error);
          return;
        }
        validando = false;
        update([validandoIdGet]);
        break;
    }
    indexPage++;
    pageController.jumpToPage(indexPage);
    update([pageIdGet]);
  }

  void goBack() {
    if (indexPage == 0) {
      Get.back();
    } else {
      indexPage--;
      pageController.jumpToPage(indexPage);
    }
    update([pageIdGet]);
  }
}
