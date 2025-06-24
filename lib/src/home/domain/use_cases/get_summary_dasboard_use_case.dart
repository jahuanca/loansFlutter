
import 'package:loands_flutter/src/home/data/responses/dashboard_summary_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetSummaryDasboardUseCase {

  SummaryRepository repository;

  GetSummaryDasboardUseCase({
    required this.repository
  });

  Future<ResultType<DashboardSummaryResponse, ErrorEntity>> execute() async {
    return repository.getSummary();
  }

}