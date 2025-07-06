import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/di/payment_summary_binding.dart';
import 'package:loands_flutter/src/home/di/quota_group_binding.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_of_calendar_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_page.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/quota_group_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class HomeCalendarController extends GetxController {
  final GetSummaryOfCalendarUseCase getSummaryOfCalendarUseCase;
  final GetQuotasByDateUseCase getQuotasByDateUseCase;
  SummaryOfCalendarResponse? summaryOfCalendarResponse;
  List<DashboardQuotaResponse> quotasByDate = [];
  DateTime dateSelected = defaultDate;

  HomeCalendarController({
    required this.getSummaryOfCalendarUseCase,
    required this.getQuotasByDateUseCase,
  });

  @override
  void onReady() {
    getSummaryOfCalendar();
    super.onReady();
  }

  Future<void> getSummaryOfCalendar() async {
    showLoading();
    ResultType<SummaryOfCalendarResponse, ErrorEntity> resultType =
        await getSummaryOfCalendarUseCase.execute();
    if (resultType is Success) {
      summaryOfCalendarResponse = resultType.data;
    }
    update([pageIdGet]);
    await getQuotasByDay(dateSelected);
    hideLoading();
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

  Future<void> goToQuota(int index) async {
    DashboardQuotaResponse quotaSelected = quotasByDate[index];
    QuotaEntity? result = await Get.to(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: quotaSelected,
    });

    if (result != null) {
      quotaSelected.idStateQuota = result.idStateQuota;
      quotaSelected.paidDate = result.paidDate;
      update([pageIdGet]);
    }
  }

  void goToPaymentSummary() {
    Get.to(() => PaymentSummaryPage(), binding: PaymentSummaryBinding());
  }

  void goToQuotaGroupOfWeek() {
    GetQuotasByDateRequest request = GetQuotasByDateRequest(
      fromDate: defaultDate.firstDateOfTheWeek(),
      untilDate: defaultDate.lastDateOfTheWeek()
    );
    
    _goToQuotaGroup(
      request: request,
      title: 'Cuotas de la semana',
    );
  }

  void goToQuotaGroupOfDefeated() {
    GetQuotasByDateRequest request = GetQuotasByDateRequest(
      idStateQuota: idOfPendingQuota,
      untilDate: defaultDate,
    );
    _goToQuotaGroup(
      request: request,
      title: 'Cuotas vencidas',
    );
  }

  void _goToQuotaGroup({
    required GetQuotasByDateRequest request, 
    required String title
  }) {
    Get.to(() => QuotaGroupPage(),
        binding: QuotaGroupBinding(),
        arguments: {
          getAllQuotasRequestArgument: request,
          titleArgument: title,
        });
  }

  void changeDatePicker(DateTime? dateTime) {
    if (dateTime == null) return;
    dateSelected = dateTime;
    getQuotasByDay(dateTime);
  }
}
