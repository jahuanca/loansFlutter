import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class PayQuotaController extends GetxController {
  late DashboardQuotaResponse quota;
  PayQuotaUseCase payQuotaUseCase;
  

  PayQuotaController({
    required this.payQuotaUseCase,
  });

  @override
  void onInit() {
    quota = Get.setArgument(dashboardQuotaResponseArgument);
    super.onInit();
  }

  void payQuota() async {
    bool? result = await showDialogWidget(
        context: Get.context!,
        message: 'Se registrara la cuota como pagada, ¿desea continuar?');
    if (result.orFalse()) {
      PayQuotaRequest payQuotaRequest =
          PayQuotaRequest(idOfQuota: quota.id, paidDate: DateTime.now());
      ResultType resultType = await payQuotaUseCase.execute(payQuotaRequest);
      if (resultType is Success) {
        Get.back();
      }
    }
  }
}
