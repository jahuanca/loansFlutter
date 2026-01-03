import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/add_loan_special_binding.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_special_loan/add_special_loan_page.dart';
import 'package:loands_flutter/src/utils/core/source_to_loan_enum.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class PayQuotaController extends GetxController {
  late SourceToLoanEnum sourceToLoanEnum;
  late bool isSpecial;

  DashboardQuotaResponse? quota;
  PayQuotaUseCase payQuotaUseCase;
  TextEditingController dateToPayTextController = TextEditingController();

  PayQuotaRequest payQuotaRequest = PayQuotaRequest();

  PayQuotaController({
    required this.payQuotaUseCase,
  });

  bool get isPending => (quota?.idStateQuota == idOfPendingQuota);

  bool get isLastQuota {
    if (quota == null) return false;
    List<String> parts = quota!.name.split('/');
    return (parts.first == parts.last);
  }

  @override
  void onInit() {
    quota = Get.setArgument(dashboardQuotaResponseArgument);
    sourceToLoanEnum = Get.setArgument(sourceToLoanArgument);
    payQuotaRequest.idOfQuota = quota?.id;
    super.onInit();
  }

  void onChangedStartDate(DateTime? date) {
    ValidateResult dateToPayValidationResult =
        validateText(text: date, label: paymentDateString, rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDatetime: true,
    });
    if (dateToPayValidationResult.hasError.not()) {
      dateToPayTextController.text = date.formatDMMYYY().orEmpty();
      payQuotaRequest.paidDate = date;
    }
    update([startDayIdGet]);
  }

  Future<bool> _goAction(String info) async {
    String? message = payQuotaRequest.messageError;
    if (message != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return false;
    }
    return await showDialogWidget(context: Get.context!, message: info);
  }

  void goPayQuota() async {
    bool goAction = await _goAction(
        'Se registrara la cuota como pagada, ¿desea continuar?');
    if (goAction) {
      showLoading();
      ResultType<QuotaEntity, ErrorEntity> resultType =
          await payQuotaUseCase.execute(payQuotaRequest);
      hideLoading();
      if (resultType is Success) {
        QuotaEntity quotaToReturn = resultType.data;
        updateQuotaAndCopy(quotaToReturn);
        Get.back(result: quotaToReturn);
      } else {
        ErrorEntity errorEntity = resultType.error;
        showSnackbarWidget(
            context: Get.context!,
            typeSnackbar: TypeSnackbar.error,
            message: errorEntity.errorMessage);
      }
    }
  }

  void goPayQuotaAndRenewLoan() async {
    bool goAction = await _goAction(
        'Se pagará la cuota y renovara el préstamo, ¿desea continuar?');
    if (goAction) {
      if (quota!.isSpecial.orFalse()) {
        goToNewSpecialLoan();
      } else {
        goToNewRegularLoan();
      }
    }
  }

  void goToNewRegularLoan() {
    Map<String, dynamic> arguments = {
      sourceToLoanArgument: sourceToLoanEnum,
      createRenewalRequestArgument: PayAndRenewalRequest(
        idLoanToRenew: quota?.idLoan,
        paidDate: payQuotaRequest.paidDate,
        idOfQuota: payQuotaRequest.idOfQuota,
      )
    };

    AddLoanInformationBinding().dependencies();

    Get.to(AddLoanInformationPage(), 
      arguments: arguments,
    );
  }

  void goToNewSpecialLoan() {
    Map<String, dynamic> arguments = {
      sourceToLoanArgument: sourceToLoanEnum,
      createRenewalRequestArgument: PayAndRenewalSpecialRequest(
        idLoanToRenew: quota?.idLoan,
        paidDate: payQuotaRequest.paidDate,
        idOfQuota: payQuotaRequest.idOfQuota,
      )
    };

    AddLoanSpecialBinding().dependencies();

    Get.to(
      AddSpecialLoanPage(),
      arguments: arguments,
    );
  }

  Future<void> updateQuotaAndCopy(QuotaEntity quotaUpdated) async {
    quota!.paidDate = quotaUpdated.paidDate;
    copyPaidQuota(false);
  }

  Future<void> copyPaidQuota([bool showSnackbar = true]) async {
    if (quota == null) return;

    String message = emptyString;
    String nameOfDate = quota!.paidDate.format(formatDate: 'EEEE').orEmpty();
    message += 'Préstamo #${quota!.idLoan}:';
    message += ' ${quota!.aliasOrName},';
    message += ' cuota ${quota!.name}';
    message += ' monto de S/ ${quota!.amount.formatDecimals()},';
    message += ' pagado el $nameOfDate ${quota!.paidDate.formatDMMYYY()}.';
    copyToClipboard(message);
    if (showSnackbar == false) return;
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Información copiada');
  }
}
