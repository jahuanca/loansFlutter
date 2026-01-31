import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class PayQuotaMultipleController extends GetxController {
  bool isPending = true;

  PayQuotaUseCase payQuotaUseCase;
  TextEditingController dateToPayTextController = TextEditingController();
  PayQuotaRequest payQuotaRequest = PayQuotaRequest();
  List<DashboardQuotaResponse> quotas = [];

  PayQuotaMultipleController({
    required this.payQuotaUseCase,
  });

  @override
  void onInit() {
    quotas = Get.setArgument(quotasSelectedArgument);
    super.onInit();
    update([pageIdGet]);
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

  Future<void> updateQuotaAndCopy(QuotaEntity quotaUpdated) async {
    /* quota!.paidDate = quotaUpdated.paidDate;
    String information = getInformationOfQuota(quota!);
    await copyToClipboard(information);
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Información copiada');*/
  }

  Future<void> copyPaidQuota() async {
    /*String information = getInformationOfQuota(quota!);
    await copyToClipboard(information);
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Información copiada');*/
  }

}
