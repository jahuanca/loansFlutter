import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/di/payment_summary_binding.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_of_dasboard_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_logs_use_case.dart';
import 'package:utils/utils.dart';

class DashboardController extends GetxController {
  final GetSummaryOfDasboardUseCase getSummaryDasboardUseCase;
  final GetQuotasByDateUseCase getQuotasByDateUseCase;
  final GetLogsUseCase getLogsUseCase;
  SummaryOfDashboardResponse? summaryOfDashboardResponse;
  List<DashboardQuotaResponse> quotasByDate = [];
  List<ActivityLogEntity> logs = [];
  DateTime dateSelected = defaultDate;

  DashboardController({
    required this.getSummaryDasboardUseCase,
    required this.getQuotasByDateUseCase,
    required this.getLogsUseCase,
  });

  @override
  void onReady() {
    getAll();
    super.onReady();
  }

  Future<void> getAll() async {
    showLoading();
    await Future.wait([
      getLogs(),
      getSummary(),
    ]);
    hideLoading();
    update([pageIdGet]);
  }

  Future<void> getLogs() async {
    ResultType<List<ActivityLogEntity>, ErrorEntity> resultType =
        await getLogsUseCase.execute();
    if (resultType is Success) {
      logs = resultType.data;
    }
  }

  Future<void> getSummary([bool updateDateSelected = true]) async {
    ResultType<SummaryOfDashboardResponse, ErrorEntity> resultType =
        await getSummaryDasboardUseCase.execute();
    if (resultType is Success) {
      summaryOfDashboardResponse = resultType.data;
      if (updateDateSelected) {
        dateSelected = defaultDate;
      }
    }
    await getQuotasByDay(dateSelected);
  }

  Future<void> getQuotasByDay(DateTime dateTime) async {
    dateSelected = dateTime;
    update([calendarIdGet]);
    showLoading();
    GetQuotasByDateRequest request = GetQuotasByDateRequest(
      fromDate: dateTime,
      untilDate: dateTime
    );
    ResultType<List<DashboardQuotaResponse>, ErrorEntity> resultType =
        await getQuotasByDateUseCase.execute(request);
    if (resultType is Success) {
      quotasByDate = resultType.data;
      update([quotasIdGet]);
    } else {
      showSnackbarWidget(
          typeSnackbar: TypeSnackbar.error,
          context: Get.context!,
          message: resultType.error.toString());
    }
    hideLoading();
  }

  void goToPaymentSummary() {
    Get.to(()=> PaymentSummaryPage(), binding: PaymentSummaryBinding());
  }

  void changeDatePicker(DateTime? dateTime) {
    if (dateTime == null) return;
    dateSelected = dateTime;
    getQuotasByDay(dateTime);
  }
}
