
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetNextRenewalUseCase {

  SummaryRepository repository;

  GetNextRenewalUseCase(this.repository);


  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> execute() {
    return repository.getNextRenewal();
  }
}