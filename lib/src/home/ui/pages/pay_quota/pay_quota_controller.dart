import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class PayQuotaController extends GetxController {
  late DashboardQuotaResponse quota;
  PayQuotaUseCase payQuotaUseCase;
  TextEditingController dateToPayTextController = TextEditingController();
  
  PayQuotaRequest payQuotaRequest = PayQuotaRequest();

  PayQuotaController({
    required this.payQuotaUseCase,
  });

  @override
  void onInit() {
    quota = Get.setArgument(dashboardQuotaResponseArgument);
    payQuotaRequest.idOfQuota = quota.id;
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

  void payQuota() async {
    String? message = payQuotaRequest.messageError;
    if(message != null){
      return showSnackbarWidget(
        context: Get.context!, 
        typeSnackbar: TypeSnackbar.error, 
        message: message);
    }
    bool result = await showDialogWidget(
        context: Get.context!,
        message: 'Se registrara la cuota como pagada, ¿desea continuar?');
    if (result) {
      showLoading();
      ResultType resultType = await payQuotaUseCase.execute(payQuotaRequest);
      hideLoading();
      if (resultType is Success) {
        Get.back();
      }
    }
  }
}
