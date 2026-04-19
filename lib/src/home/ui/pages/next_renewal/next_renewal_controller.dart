import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_next_renewal_use_case.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/ui/navigation_to.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class NextRenewalController extends GetxController {
  GetNextRenewalUseCase getNextRenewalUseCase;

  List<DashboardQuotaResponse> quotas = [];

  NextRenewalController({
    required this.getNextRenewalUseCase,
  });

  @override
  void onReady() {
    getRenewals();
    super.onReady();
  }

  void getRenewals() async {
    showLoading();
    ResultType<List<DashboardQuotaResponse>, ErrorEntity> resultType =
        await getNextRenewalUseCase.execute();
    hideLoading();
    if (resultType is Success) {
      quotas = resultType.data;
      update([pageIdGet]);
    }
  }

  void goToDetail(LoanEntity loanSelected) async {
    Map<String, dynamic> arguments = {loanSelectedArgument: loanSelected};
    await NavigationTo.goToLoanDetail(arguments);
  }

  void onChangedMenuOverlay(dynamic option) async {
    if (option.id == 2) {
      String data = emptyString;
      Map<dynamic, List<Map<String, dynamic>>> groupByDate = {};
      groupByDate = groupBy(
          values: quotas
              .map(
                (e) => e.toJson(),
              )
              .toList(),
          functionKey: (p0) => p0['date_to_pay']);

      groupByDate.forEach(
        (key, value) {
          DateTime dateOfTitle = DateTime.parse(key);
          String title = dateOfTitle
              .format(formatDate: FormatDate.summary)
              .orEmpty()
              .toCapitalize();
          data += '\n$title\n';
          for (Map<String, dynamic> element in value) {
            DashboardQuotaResponse quota =
                DashboardQuotaResponse.fromJson(element);
            if (quota.idStateQuota != idOfPendingQuota) continue;
            double amount = quota.amount;
            double sendMe = amount - (quota.ganancy / 2);
            data +=
                'P#${quota.idLoan} ${quota.aliasOrName}: S/${quota.amountOfLoan?.formatDecimals()}\nCuota ${quota.name}, monto: ${amount.formatDecimals()}, envíame: ${sendMe.formatDecimals()}\n';
          }
        },
      );
      await copyToClipboard(data);
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.success,
          message: 'Cuotas copiadas.');
    }
  }
}
