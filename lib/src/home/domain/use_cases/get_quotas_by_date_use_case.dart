
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/dashboard_repository.dart';
import 'package:utils/utils.dart';

class GetQuotasByDateUseCase {

  DashboardRepository repository;

  GetQuotasByDateUseCase({
    required this.repository,
  });

    Future<ResultType<List<DashboardQuotaResponse>,ErrorEntity>> execute(DateTime date) {
      return repository.getQuotasByDate(date);
    }
}