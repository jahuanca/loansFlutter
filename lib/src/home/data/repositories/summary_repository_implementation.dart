
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/domain/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';


class SummaryRepositoryImplementation extends SummaryRepository {

  SummaryDatastore datastore;

  SummaryRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<SummaryOfDashboardResponse, ErrorEntity>> getSummaryOfDashboard() {
    return datastore.getSummaryOfDashboard();
  }

  @override
  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(GetQuotasByDateRequest request) {
    return datastore.getQuotasByDate(request);
  }

  @override
  Future<ResultType<QuotaEntity, ErrorEntity>> payQuota(PayQuotaRequest payQuotaRequest) {
    return datastore.payQuota(payQuotaRequest);
  }
  
  @override
  Future<ResultType<List<SummaryMonthResponse>, ErrorEntity>> getSummaryMonths() {
    return datastore.getSummaryMonths();
  }

  @override
  Future<ResultType<SummaryOfCalendarResponse, ErrorEntity>> getSummaryOfCalendar() {
    return datastore.getSummaryOfCalendar();
  }
}