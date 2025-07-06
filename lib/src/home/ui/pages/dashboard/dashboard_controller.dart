import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customers_binding.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_page.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/di/payment_summary_binding.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_of_dasboard_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/home/ui/pages/payment_summary/payment_summary_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/di/loans_binding.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class DashboardController extends GetxController {
  final GetSummaryOfDasboardUseCase getSummaryDasboardUseCase;
  final GetQuotasByDateUseCase getQuotasByDateUseCase;
  SummaryOfDashboardResponse? summaryOfDashboardResponse;
  List<DashboardQuotaResponse> quotasByDate = [];
  DateTime dateSelected = defaultDate;

  DashboardController({
    required this.getSummaryDasboardUseCase,
    required this.getQuotasByDateUseCase,
  });

  @override
  void onReady() {
    getSummary();
    super.onReady();
  }

  Future<void> getSummary([bool updateDateSelected = true]) async {
    showLoading();
    ResultType<SummaryOfDashboardResponse, ErrorEntity> resultType =
        await getSummaryDasboardUseCase.execute();
    if (resultType is Success) {
      summaryOfDashboardResponse = resultType.data;
      if (updateDateSelected) {
        dateSelected = defaultDate;
      }
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

  void goToLoans() {
    Get.to(() => LoansPage(), binding: LoansBinding());
  }

  void goToCustomers() {
    Get.to(() => CustomersPage(), binding: CustomersBinding());
  }

  Future<void> goToQuota(DashboardQuotaResponse quotaResponse) async {
    final result = await Get.to(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: quotaResponse,
    });
    getSummary((result is QuotaEntity).not());
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
