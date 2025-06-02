
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_summary_response.dart';
import 'package:loands_flutter/src/home/domain/datastores/dashboard_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/dashboard_repository.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';


class DashboardRepositoryImplementation extends DashboardRepository {

  DashboardDatastore datastore;

  DashboardRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<DashboardSummaryResponse, ErrorEntity>> getSummary() {
    return datastore.getSummary();
  }

  @override
  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(DateTime date) {
    return datastore.getQuotasByDate(date);
  }

  @override
  Future<ResultType<QuotaEntity, ErrorEntity>> payQuota(PayQuotaRequest payQuotaRequest) {
    return datastore.payQuota(payQuotaRequest);
  }
}