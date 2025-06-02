
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_summary_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class DashboardDatastore {
  
  Future<ResultType<DashboardSummaryResponse, ErrorEntity>> getSummary();
  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(DateTime date);
  Future<ResultType<QuotaEntity, ErrorEntity>> payQuota(PayQuotaRequest payQuotaRequest);
}