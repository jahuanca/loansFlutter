import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_online_datastore.dart';
import 'package:loands_flutter/src/home/data/repositories/summary_repository_implementation.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_capital_movements_group_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/capital_movements/capital_movements_controller.dart';

class CapitalMovementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryDatastore>(() => SummaryOnlineDatastore());

    Get.lazyPut<SummaryRepository>(
        () => SummaryRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut(() => GetCapitalMovementsGroupUseCase(Get.find()));
    Get.lazyPut(() => CapitalMovementsController(getCapitalMovementsGroupUseCase: Get.find()));
  }
}
