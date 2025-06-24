
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetSummaryMonthsUseCase {

  SummaryRepository repository;

  GetSummaryMonthsUseCase({
    required this.repository
  });

  Future<ResultType<List<SummaryMonthResponse>, ErrorEntity>> execute() async {
    return repository.getSummaryMonths();
  }

}