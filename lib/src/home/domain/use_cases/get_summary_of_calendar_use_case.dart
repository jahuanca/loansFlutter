
import 'package:loands_flutter/src/home/data/responses/summary_of_calendar_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetSummaryOfCalendarUseCase {

  SummaryRepository repository;

  GetSummaryOfCalendarUseCase({
    required this.repository
  });

  Future<ResultType<SummaryOfCalendarResponse, ErrorEntity>> execute() async {
    return repository.getSummaryOfCalendar();
  }
}