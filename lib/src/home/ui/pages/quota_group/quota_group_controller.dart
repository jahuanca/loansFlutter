import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota_multiple/pay__quota_multiple_page.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/mode_group_enum.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/type_group_enum.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/ui/widgets/options_enum.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_service.dart';
import 'package:loands_flutter/src/utils/core/analytics/screen_events.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:loands_flutter/src/utils/core/source_to_loan_enum.dart';
import 'package:loands_flutter/src/utils/ui/pages/routes_app.dart';
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
  TypeGroupEnum typeGroup = TypeGroupEnum.defeated;
  bool isSearching = false;
  OriginsRoute? originsRoute;
  ModeGroupEnum modeGroup = ModeGroupEnum.single;

  List<DashboardQuotaResponse> quotasSelected = [];

  QuotaGroupController({
    required this.getQuotasByDateUseCase,
  });

  @override
  void onInit() {
    originsRoute = Get.setArgument(originArgument);
    getQuotasByDateRequest = Get.setArgument(getAllQuotasRequestArgument);
    title = Get.setArgument(titleArgument);
    typeGroup = Get.setArgument(typeGroupArgument);

    switch (typeGroup) {
      case TypeGroupEnum.defeated:
        screenEvent(ScreenEvents.expiredQuotas);
        break;

      case TypeGroupEnum.week:
        screenEvent(ScreenEvents.weekQuotas);
        dateTimeRange = DateTimeRange(
          start: getQuotasByDateRequest.fromDate.orNow(),
          end: getQuotasByDateRequest.untilDate.orNow(),
        );
        break;
    }
    super.onInit();
  }

  @override
  void onReady() {
    getQuotas();
    super.onReady();
  }

  void onBackPressed() {
    if (originsRoute != null) {
      RoutesApp.goToNavigationContent(type: TypeMovementRoute.offAll);
    } else {
      Get.back();
    }
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
        .map((e) => (e.idStateQuota == idOfPendingQuota)
            ? (e.amount - e.ganancy)
            : defaultDouble)
        .toList();
    return (pendingCapital.isNotEmpty)
        ? pendingCapital.reduce((value, element) => value + element)
        : defaultDouble;
  }

  Future<void> getQuotas() async {
    showLoading();
    Result<List<DashboardQuotaResponse>> resultType =
        await getQuotasByDateUseCase.execute(getQuotasByDateRequest);
    hideLoading();
    switch (resultType) {
      case Success():
        allQuotas = resultType.value;
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
        break;
      case Error():
        break;
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
    if (option.id == OptionsEnum.copy.id) {
      String data = emptyString;
      groupByDate.forEach(
        (key, value) {
          DateTime dateOfTitle = DateTime.parse(key);
          String title = dateOfTitle
              .format(formatDate: FormatDate.summary)
              .orEmpty()
              .toCapitalize();
          bool hasTitle = false;
          double totalAmount = 0;
          double totalSendMe = 0;
          for (Map<String, dynamic> element in value) {
            DashboardQuotaResponse quota =
                DashboardQuotaResponse.fromJson(element);
            if (quota.idStateQuota != idOfPendingQuota) continue;

            if (hasTitle.not()) {
              data += '\n$title\n';
              hasTitle = true;
            }
            double amount = quota.amount;
            double sendMe = amount - (quota.ganancy / 2);
            totalAmount += amount;
            totalSendMe += sendMe;
            data +=
                'P#${quota.idLoan} ${quota.aliasOrName}, cuota ${quota.name}, monto: ${amount.formatDecimals()}, envíame: ${sendMe.formatDecimals()}\n';            
          }
          if (value.length > 1 && totalAmount > 0) {
            data += "Total: ${totalAmount.formatDecimals()} \tA caja: ${totalSendMe.formatDecimals()}\n";         
          }
        },
      );
      await copyToClipboard(data);
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.success,
          message: 'Cuotas copiadas.');
    }

    if (option.id == OptionsEnum.check.id) {
      switch (modeGroup) {
        case ModeGroupEnum.single: 
          modeGroup = ModeGroupEnum.multiple;
          break;
        case ModeGroupEnum.multiple: 
          modeGroup = ModeGroupEnum.single;
          break;
      }
      update([pageIdGet]);
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

  bool? getValueOfDayCheck(List<DashboardQuotaResponse> items) {
    if (quotasSelected.isEmpty) return false;
    if (items.every((item) => quotasSelected.indexWhere((e) => e.id == item.id,) != notFoundPosition)){
      return true;
    } else {
      if (quotasSelected.any((e) => items.indexWhere((item) => item.id == e.id) != notFoundPosition)) {
        return null;
      } else {
        return false;
      }
    }
  }

  void checkDay(bool? lastValue, List<DashboardQuotaResponse> quotasPendingOfDay) {
    switch (lastValue) {
      case true:
          for (DashboardQuotaResponse q in quotasPendingOfDay) {
            quotasSelected.removeWhere((e) => e.id == q.id);
          }
        break;
      case false:
          for (DashboardQuotaResponse q in quotasPendingOfDay) {
            int index = quotasSelected.indexWhere((e) => e.id == q.id);
            quotasSelected.addIf(index == notFoundPosition, q);
          }
        break;

      case null:
          for (DashboardQuotaResponse q in quotasPendingOfDay) {
            int index = quotasSelected.indexWhere((e) => e.id == q.id);
            quotasSelected.addIf(index == notFoundPosition, q);
          }
        break;
    }
    update([pageIdGet]);
  }

  void selectQuota(DashboardQuotaResponse value) {
    int index = quotasSelected.indexWhere((e) => e.id == value.id);
    if (index == notFoundPosition) {
      quotasSelected.add(value);
    } else {
      quotasSelected.removeAt(index);
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
