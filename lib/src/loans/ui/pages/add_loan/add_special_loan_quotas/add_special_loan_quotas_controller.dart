import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_special_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanQuotasController extends GetxController {
  late AddSpecialLoanRequest addLoanSpecialRequest;
  CreateSpecialLoanUseCase createSpecialLoanUseCase;
  List<QuotaEntity> quotas = [];
  late double percentage;

  AddSpecialLoanQuotasController({
    required this.createSpecialLoanUseCase,
  });

  @override
  void onInit() {
    addLoanSpecialRequest = Get.setArgument(addLoanRequestArgument);
    setSpecialQuotas();
    super.onInit();
  }

  void setSpecialQuotas() {
    int quantity =
        addLoanSpecialRequest.numberOfInstallments ??
            defaultInt;
    DateTime startDate = addLoanSpecialRequest.startDate ?? defaultDate;
    int daysInstallment =
        addLoanSpecialRequest.daysBetweenInstallments ??
            defaultInt;
    percentage = addLoanSpecialRequest.percentage ?? defaultDouble;
    double amount = addLoanSpecialRequest.amount ?? defaultDouble;

    final double amountQuota = (amount * (1 + (percentage / 100)) / quantity);
    final double amortization = (amount / quantity);
    final double interest = amountQuota - amortization;

    for (var i = defaultInt; i < quantity; i++) {
      startDate = startDate.add(Duration(days: daysInstallment));
      QuotaEntity quota = QuotaEntity(
          name: '${i + 1}/$quantity',
          description: emptyString,
          amount: amountQuota,
          dateToPay: startDate,
          idStateQuota: idStateQuotaOfPending,
          ganancy: interest);
      quotas.add(quota);
    }
    update([pageIdGet]);
  }

  void create() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Esta seguro de crear el préstamo?');
    if (result == false) return;
    showLoading();
    ResultType<LoanEntity, ErrorEntity> resultType =
        await createSpecialLoanUseCase.execute(addLoanSpecialRequest);
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
