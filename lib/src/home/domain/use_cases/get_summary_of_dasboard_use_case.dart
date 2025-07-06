
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetSummaryOfDasboardUseCase {

  SummaryRepository repository;

  GetSummaryOfDasboardUseCase({
    required this.repository
  });

  Future<ResultType<SummaryOfDashboardResponse, ErrorEntity>> execute() async {
    return repository.getSummaryOfDashboard();
  }
}