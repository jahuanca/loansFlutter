import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class PayQuotaController extends GetxController {
  late DashboardQuotaResponse quota;
  PayQuotaUseCase payQuotaUseCase;
  ValidateResult? dateToPayValidationResult;
  TextEditingController dateToPayTextController = TextEditingController();
  

  PayQuotaController({
    required this.payQuotaUseCase,
  });

  @override
  void onInit() {
    quota = Get.setArgument(dashboardQuotaResponseArgument);
    super.onInit();
  }

  void onChangedStartDate(DateTime? date) {
    dateToPayValidationResult =
        validateText(text: date, label: 'Fecha de pago', rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDatetime: true,
    });
    if (dateToPayValidationResult!.hasError) {
    } else {
      dateToPayTextController.text = date.formatDMMYYY().orEmpty();
    }
    update(['start_date']);
  }

  void payQuota() async {
    if(dateToPayValidationResult?.hasError ?? false ){
      return showSnackbarWidget(
        context: Get.context!, 
        typeSnackbar: TypeSnackbar.error, 
        message: 'Registre una fecha de pago');
    }
    bool? result = await showDialogWidget(
        context: Get.context!,
        message: 'Se registrara la cuota como pagada, ¿desea continuar?');
    if (result.orFalse()) {
      showLoading();
      PayQuotaRequest payQuotaRequest =
          PayQuotaRequest(idOfQuota: quota.id, paidDate: dateToPayValidationResult?.value);
      ResultType resultType = await payQuotaUseCase.execute(payQuotaRequest);
      hideLoading();
      if (resultType is Success) {
        Get.back();
      }
    }
  }
}
