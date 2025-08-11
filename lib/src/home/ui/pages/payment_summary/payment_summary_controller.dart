import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/summary_month_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_months_use_case.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
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

  double get totalOfGanancy {
    List<double> amounts = summary
      .map(
        (e) => (e.idStateQuota == idOfCompleteLoan) ? e.ganancy : defaultDouble,
      ).toList();
    return (amounts.isEmpty) ? defaultDouble : amounts.reduce((value, element) => value + element);
  }

  double get totalOfLoss {
    List<double> amounts = summary
      .map(
        (e) => (e.idStateQuota == idOfPendingLoan) ? e.amount : defaultDouble,
      ).toList();
    return (amounts.isEmpty) ? defaultDouble : amounts.reduce((value, element) => value + element);
  }

  double get total => totalOfGanancy - totalOfLoss;

  Future<void> getSummaryMonths() async {
    showLoading();
    ResultType<List<SummaryMonthResponse>, ErrorEntity> resultType =
        await getSummaryMonthsUseCase.execute();
    hideLoading();
    if (resultType is Success) {
      summary = resultType.data;
    }
    update([pageIdGet]);
  }
  
}
