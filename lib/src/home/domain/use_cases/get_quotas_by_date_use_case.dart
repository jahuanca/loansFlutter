
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:utils/utils.dart';

class GetQuotasByDateUseCase {

  SummaryRepository repository;

  GetQuotasByDateUseCase({
    required this.repository,
  });

    Future<ResultType<List<DashboardQuotaResponse>,ErrorEntity>> execute(GetQuotasByDateRequest request) {
      return repository.getQuotasByDate(request);
    }
}