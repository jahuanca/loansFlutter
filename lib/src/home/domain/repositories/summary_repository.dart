
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class SummaryRepository {
  Future<ResultType<SummaryOfDashboardResponse, ErrorEntity>> getSummaryOfDashboard();
  Future<ResultType<SummaryOfCalendarResponse, ErrorEntity>> getSummaryOfCalendar();
  Future<ResultType<List<SummaryMonthResponse>, ErrorEntity>> getSummaryMonths();
  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(GetQuotasByDateRequest request);
  Future<ResultType<QuotaEntity, ErrorEntity>> payQuota(PayQuotaRequest payQuotaRequest);
}