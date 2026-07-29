import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class SummaryOnlineDatastore extends SummaryDatastore {

  @override
  Future<Result<SummaryOfDashboardResponse>> getSummaryOfDashboard() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/utils/summary-of-dashboard',
    );
    return executeResponseObject<SummaryOfDashboardResponse>(
        response: response, convert: SummaryOfDashboardResponse.fromJson);
  }

  @override
  Future<Result<List<DashboardQuotaResponse>>> getQuotasByDate(
      GetQuotasByDateRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
        url: '/utils/quotasOfDate',
        query: request.toJson());
    return executeResponseList<DashboardQuotaResponse>(
        response: response, convert: dashboardQuotasResponseFromJson);
  }

  @override
  Future<Result<QuotaEntity>> payQuota(
      PayQuotaRequest payQuotaRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.post(url: '/quota/pay', body: payQuotaRequest.toJson());
    
    return executeResponseObject<QuotaEntity>(
        response: response, convert: QuotaEntity.fromJson);
  }
  
  @override
  Future<Result<List<SummaryMonthResponse>>> getSummaryMonths() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/utils/summary-months');
    
    return executeResponseList<SummaryMonthResponse>(
        response: response, convert: summaryMonthFromJson);
  }
  
  @override
  Future<Result<SummaryOfCalendarResponse>> getSummaryOfCalendar() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/utils/summary-of-calendar',
    );

    return executeResponseObject<SummaryOfCalendarResponse>(
        response: response, convert: SummaryOfCalendarResponse.fromJson);
  }

  @override
  Future<Result<List<DashboardQuotaResponse>>> getNextRenewal() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/utils/next-renewal',
    );
    return executeResponseList<DashboardQuotaResponse>(
        response: response, convert: dashboardQuotasResponseFromJson);
  }

  @override
  Future<Result<List<InjectionResponse>>> getInjections() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/utils/injections',
    );

    return executeResponseList<InjectionResponse>(
        response: response, convert: injectionResponseFromJson);
  }
}
