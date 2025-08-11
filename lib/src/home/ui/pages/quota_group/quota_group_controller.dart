import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class QuotaGroupController extends GetxController {
  GetQuotasByDateUseCase getQuotasByDateUseCase;
  late GetQuotasByDateRequest getQuotasByDateRequest;
  String title = emptyString;

  List<DashboardQuotaResponse> quotas = [];
  Map<dynamic, List<Map<String, dynamic>>> groupByDate = {};
  DateTimeRange? dateTimeRange;
  bool isGroup = false;

  QuotaGroupController({
    required this.getQuotasByDateUseCase,
  });

  @override
  void onInit() {
    getQuotasByDateRequest = Get.setArgument(getAllQuotasRequestArgument);
    title = Get.setArgument(titleArgument);
    isGroup = Get.setArgument(isGroupArgument);
    if(isGroup) {
      dateTimeRange = DateTimeRange(
        start: getQuotasByDateRequest.fromDate.orNow(), 
        end: getQuotasByDateRequest.untilDate.orNow(), 
      );
    }
    super.onInit();
  }

  @override
  void onReady() {
    getQuotas();
    super.onReady();
  }

  Future<void> getQuotas() async {
    showLoading();
    ResultType<List<DashboardQuotaResponse>, ErrorEntity> resultType =
        await getQuotasByDateUseCase.execute(getQuotasByDateRequest);
    hideLoading();

    if (resultType is Success) {
      quotas = resultType.data;
      groupByDate = groupBy(
        values: quotas
            .map(
              (e) => e.toJson(),
            )
            .toList(),
        functionKey: (p0) => p0['date_to_pay'],
      );
      update([pageIdGet]);
    }
  }

  Future<void> goToQuota(int idOfQuota) async {
    int index = quotas.indexWhere(
      (e) => e.id == idOfQuota,
    );
    DashboardQuotaResponse quotaSelected = quotas[index];
    QuotaEntity? result = await Get.to(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: quotaSelected,
    });
    if (result != null) {
      quotaSelected.idStateQuota = result.idStateQuota;
      quotaSelected.paidDate = result.paidDate;
      update([pageIdGet]);
    }
  }

  void onChangedMenuOverlay(dynamic option) async {
    if (option.id == 2) {
      String data = emptyString;
      groupByDate.forEach(
        (key, value) {
          DateTime dateOfTitle = DateTime.parse(key);
          String title = dateOfTitle
              .format(formatDate: formatOfSummary)
              .orEmpty()
              .toCapitalize();
          data += '\n$title\n';
          for (Map<String, dynamic> element in value) {
            DashboardQuotaResponse quota = DashboardQuotaResponse.fromJson(element);
            if (quota.idStateQuota != idOfPendingQuota) continue;
            double amount = quota.amount;
            double sendMe = amount - (quota.ganancy/2);
            data += 'P#${quota.idLoan} ${quota.aliasOrName}, cuota ${quota.name}, monto: ${amount.formatDecimals()}, envíame: ${sendMe.formatDecimals()}\n'; 
          }
        },
      );
      await copyToClipboard(data);
      showSnackbarWidget(context: Get.context!, typeSnackbar: TypeSnackbar.success, message: 'Cuotas copiadas.');
    }
  }

  void onChangedDateTimeRange(DateTimeRange? value) {
    if (value == null) return;
    dateTimeRange = value;
    getQuotasByDateRequest.fromDate = value.start;
    getQuotasByDateRequest.untilDate = value.end;
    _setTitle();
    getQuotas();
  }

  void _setTitle() {
    String startDate = dateTimeRange!.start.formatDMMYYY().orEmpty();
    String endDate = dateTimeRange!.end.formatDMMYYY().orEmpty();
    title = '$startDate - $endDate';
  }

}
