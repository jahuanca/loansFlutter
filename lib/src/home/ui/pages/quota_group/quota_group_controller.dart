import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota_multiple/pay__quota_multiple_page.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:loands_flutter/src/utils/core/source_to_loan_enum.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class QuotaGroupController extends GetxController {
  GetQuotasByDateUseCase getQuotasByDateUseCase;
  late GetQuotasByDateRequest getQuotasByDateRequest;
  String title = emptyString;

  List<DashboardQuotaResponse> allQuotas = [];
  List<DashboardQuotaResponse> quotasToShow = [];
  Map<dynamic, List<Map<String, dynamic>>> groupByDate = {};
  DateTimeRange? dateTimeRange;
  bool isGroup = false;
  bool isSearching = false;

  List<DashboardQuotaResponse> quotasSelected = [];

  QuotaGroupController({
    required this.getQuotasByDateUseCase,
  });

  bool get isMultiple => quotasSelected.isNotEmpty;

  @override
  void onInit() {
    getQuotasByDateRequest = Get.setArgument(getAllQuotasRequestArgument);
    title = Get.setArgument(titleArgument);
    isGroup = Get.setArgument(isGroupArgument);
    if (isGroup) {
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

  double get amountOfCapital {
    List<double> capital = allQuotas.map((e) => e.amount - e.ganancy).toList();
    return (capital.isNotEmpty)
        ? capital.reduce((value, element) => value + element)
        : defaultDouble;
  }

  double get amountOfGanancy {
    List<double> ganancy = allQuotas.map((e) => e.ganancy).toList();
    return (ganancy.isNotEmpty)
        ? ganancy.reduce((value, element) => value + element)
        : defaultDouble;
  }

  double get amountOfPendingGanancy {
    List<double> pendingGanancy = allQuotas
        .map((e) =>
            (e.idStateQuota == idOfPendingQuota) ? e.ganancy : defaultDouble)
        .toList();
    return (pendingGanancy.isNotEmpty)
        ? pendingGanancy.reduce((value, element) => value + element)
        : defaultDouble;
  }

  double get amountOfPendingCapital {
    List<double> pendingCapital = allQuotas
        .map((e) =>
            (e.idStateQuota == idOfPendingQuota) ? (e.amount - e.ganancy) : defaultDouble)
        .toList();
    return (pendingCapital.isNotEmpty)
        ? pendingCapital.reduce((value, element) => value + element)
        : defaultDouble;
  }

  Future<void> getQuotas() async {
    showLoading();
    ResultType<List<DashboardQuotaResponse>, ErrorEntity> resultType =
        await getQuotasByDateUseCase.execute(getQuotasByDateRequest);
    hideLoading();

    if (resultType is Success) {
      allQuotas = resultType.data;
      groupByDate = groupBy(
        values: allQuotas
            .map(
              (e) => e.toJson(),
            )
            .toList(),
        functionKey: (p0) => p0['date_to_pay'],
      );

      quotasToShow = allQuotas.toList();
      update([pageIdGet]);
    }
  }

  Future<void> goToQuota(int idOfQuota) async {
    int index = allQuotas.indexWhere(
      (e) => e.id == idOfQuota,
    );
    DashboardQuotaResponse quotaSelected = allQuotas[index];
    QuotaEntity? result = await Get.to(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: quotaSelected,
      sourceToLoanArgument: SourceToLoanEnum.quotaGroup,
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
              .format(formatDate: FormatDate.summary)
              .orEmpty()
              .toCapitalize();
          if (value.isNotEmpty) data += '\n$title\n';
          for (Map<String, dynamic> element in value) {
            DashboardQuotaResponse quota =
                DashboardQuotaResponse.fromJson(element);
            if (quota.idStateQuota != idOfPendingQuota) continue;
            double amount = quota.amount;
            double sendMe = amount - (quota.ganancy / 2);
            data +=
                'P#${quota.idLoan} ${quota.aliasOrName}, cuota ${quota.name}, monto: ${amount.formatDecimals()}, envíame: ${sendMe.formatDecimals()}\n';
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

  void onLongPress(DashboardQuotaResponse value) {
    int index = quotasSelected.indexWhere((e) => e.id == value.id);
    if (index == notFoundPosition) {
      quotasSelected.add(value);
    } else {
      quotasSelected.remove(value);
    }
    update([pageIdGet]);
  }

  void goToMultiplePay() {
    if (quotasSelected.isEmpty) return;
    Get.to(() => PayQuotaMultiplePage(), arguments: {
      quotasSelectedArgument: quotasSelected,
    });
  }

  void onChangedSearch(String value) {
    if (value == emptyString) {
      clearSearch();
      return;
    }
    isSearching = true;
    quotasToShow.clear();
    quotasToShow.addAll(allQuotas.where(
        (e) => e.aliasOrName.toLowerCase().contains(value.toLowerCase())));
    update([pageIdGet]);
  }

  void clearSearch() {
    isSearching = false;
    quotasToShow.clear();
    quotasToShow.addAll(allQuotas);
    update([pageIdGet]);
  }

}
