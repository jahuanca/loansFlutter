import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/datastores/dashboard_online_datastore.dart';
import 'package:loands_flutter/src/home/data/repositories/dashboard_repository_implementation.dart';
import 'package:loands_flutter/src/home/domain/datastores/dashboard_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/dashboard_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_dasboard_use_case.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';

class DashboardBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<DashboardDatastore>(() => DashboardOnlineDatastore());
    Get.lazyPut<DashboardRepository>(
        () => DashboardRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetSummaryDasboardUseCase(repository: Get.find()));
    Get.lazyPut(() => GetQuotasByDateUseCase(repository: Get.find()));
    Get.lazyPut(() => PayQuotaUseCase(repository: Get.find()), fenix: true);


    Get.put(DashboardController(
          getSummaryDasboardUseCase: Get.find(),
          getQuotasByDateUseCase: Get.find(),
        ));
  }
}
