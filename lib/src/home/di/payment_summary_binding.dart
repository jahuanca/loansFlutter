import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_online_datastore.dart';
import 'package:loands_flutter/src/home/data/repositories/summary_repository_implementation.dart';
import 'package:loands_flutter/src/home/domain/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_months_use_case.dart';

class PaymentSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryDatastore>(() => SummaryOnlineDatastore());
    Get.lazyPut<SummaryRepository>(
        () => SummaryRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetSummaryMonthsUseCase(repository: Get.find()));

  }
}
