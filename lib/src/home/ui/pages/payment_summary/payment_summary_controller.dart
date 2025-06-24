
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_months_use_case.dart';
import 'package:utils/utils.dart';

class PaymentSummaryController extends GetxController {
  
  GetSummaryMonthsUseCase getSummaryMonthsUseCase;
  List<SummaryMonthResponse> summary = [];

  PaymentSummaryController({
    required this.getSummaryMonthsUseCase,
  });

  @override
  void onReady() {
    getSummaryMonths();
    super.onReady();
  }

  void getSummaryMonths() async {
    ResultType<List<SummaryMonthResponse>, ErrorEntity> resultType = await getSummaryMonthsUseCase.execute();
    if (resultType is Success) {
      summary = resultType.data;
    }
    update([pageIdGet]);
  }

}