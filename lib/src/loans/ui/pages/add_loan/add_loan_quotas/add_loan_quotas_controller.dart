import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class AddLoanQuotasController extends GetxController {
  late AddLoanRequest addLoanRequest;
  CreateLoanUseCase createLoanUseCase;

  AddLoanQuotasController({
    required this.createLoanUseCase,
  });

  @override
  void onInit() {
    addLoanRequest = Get.setArgument(addLoanRequestArgument);
    super.onInit();
  }

  void create() async {
    bool result = await showDialogWidget(context: Get.context!, message: '¿Esta seguro de crear el préstamo?');
    if(result == false) return;
    showLoading();
    ResultType<LoanEntity, ErrorEntity> resultType =
        await createLoanUseCase.execute(addLoanRequest);
    if (resultType is Error) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: resultType.error);
      return;
    } else {
      Get.until((route) => route.settings.name == '/LoansPage');
    }
    hideLoading();
  }
}
