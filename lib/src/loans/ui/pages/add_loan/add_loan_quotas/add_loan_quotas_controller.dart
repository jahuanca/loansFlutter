import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class AddLoanQuotasController extends GetxController {
  late AddLoanRequest addLoanRequest;
  CreateLoanUseCase createLoanUseCase;
  List<QuotaEntity> quotas = [];
  late double percentage;

  AddLoanQuotasController({
    required this.createLoanUseCase,
  });

  @override
  void onInit() {
    addLoanRequest = Get.setArgument(addLoanRequestArgument);
    setQuotas();
    super.onInit();
  }

  void setQuotas() {
    int quantity = addLoanRequest.paymentFrequencyEntity?.monthlyInstallments ?? defaultInt;
    DateTime startDate = addLoanRequest.startDate ?? defaultDate;
    int daysInstallment = addLoanRequest.paymentFrequencyEntity?.daysInstallment ?? defaultInt;
    percentage = addLoanRequest.percentage ?? defaultDouble;
    double amount = addLoanRequest.amount ?? defaultDouble;

    final double amountQuota = (amount * (1 + (percentage / 100)) / quantity);
    final double amortization = (amount / quantity);
    final double interest = amountQuota - amortization;

    for (var i = defaultInt; i < quantity; i++) {
      startDate = startDate.add(Duration(days: daysInstallment));
      QuotaEntity quota = QuotaEntity(
        name: '${i+1}/$quantity', 
        description: emptyString, 
        amount: amountQuota,
        dateToPay: startDate,
        idStateQuota: idOfPendingQuota,
        ganancy: interest);
      quotas.add(quota);
    }
    update([pageIdGet]);
  }

  void create() async {
    bool result = await showDialogWidget(context: Get.context!, message: '¿Esta seguro de crear el préstamo?');
    if(result == false) return;
    showLoading();
    ResultType<LoanEntity, ErrorEntity> resultType =
        await createLoanUseCase.execute(addLoanRequest);
    if (resultType is Error) {
      ErrorEntity errorEntity = resultType.error;
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.errorMessage);
      return;
    } else {
      Get.until((route) => route.settings.name == '/');
    }
    hideLoading();
  }
}
