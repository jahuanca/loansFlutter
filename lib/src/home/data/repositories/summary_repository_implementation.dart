
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
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
  Future<Result<SummaryOfDashboardResponse, ErrorEntity>> getSummaryOfDashboard() {
    return datastore.getSummaryOfDashboard();
  }

  @override
  Future<Result<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(GetQuotasByDateRequest request) {
    return datastore.getQuotasByDate(request);
  }

  @override
  Future<Result<QuotaEntity, ErrorEntity>> payQuota(PayQuotaRequest payQuotaRequest) {
    return datastore.payQuota(payQuotaRequest);
  }
  
  @override
  Future<Result<List<SummaryMonthResponse>, ErrorEntity>> getSummaryMonths() {
    return datastore.getSummaryMonths();
  }

  @override
  Future<Result<SummaryOfCalendarResponse, ErrorEntity>> getSummaryOfCalendar() {
    return datastore.getSummaryOfCalendar();
  }

  @override
  Future<Result<List<DashboardQuotaResponse>, ErrorEntity>> getNextRenewal() {
    return datastore.getNextRenewal();
  }

  @override
  Future<Result<List<InjectionResponse>, ErrorEntity>> getInjections() {
    return datastore.getInjections();
  }
}