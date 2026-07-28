
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:utils/utils.dart';

class SummaryOfflineDatastore extends SummaryDatastore {
  @override
  Future<Result<List<InjectionResponse>>> getInjections() {
    // TODO: implement getInjections
    throw UnimplementedError();
  }

  @override
  Future<Result<List<DashboardQuotaResponse>>> getNextRenewal() {
    // TODO: implement getNextRenewal
    throw UnimplementedError();
  }

  @override
  Future<Result<List<DashboardQuotaResponse>>> getQuotasByDate(GetQuotasByDateRequest request) {
    // TODO: implement getQuotasByDate
    throw UnimplementedError();
  }

  @override
  Future<Result<List<SummaryMonthResponse>>> getSummaryMonths() {
    // TODO: implement getSummaryMonths
    throw UnimplementedError();
  }

  @override
  Future<Result<SummaryOfCalendarResponse>> getSummaryOfCalendar() {
    // TODO: implement getSummaryOfCalendar
    throw UnimplementedError();
  }

  @override
  Future<Result<SummaryOfDashboardResponse>> getSummaryOfDashboard() async {
    final box = Hive.box<SummaryOfDashboardResponse>(HiveDbAdapters.summaryOfDashboard.source);
    final values = box.values.toList();
    return Result.success(values.first);
  }

  @override
  Future<Result<QuotaEntity>> payQuota(PayQuotaRequest payQuotaRequest) {
    // TODO: implement payQuota
    throw UnimplementedError();
  }
}