import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_online_datastore.dart';
import 'package:loands_flutter/src/home/data/repositories/summary_repository_implementation.dart';
import 'package:loands_flutter/src/home/domain/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_of_dasboard_use_case.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_logs_use_case.dart';

class DashboardBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyReplace<SummaryDatastore>(() => SummaryOnlineDatastore());
    Get.lazyReplace<UtilsDatastore>(() => UtilsOnlineDatastore());

    Get.lazyReplace<SummaryRepository>(
        () => SummaryRepositoryImplementation(datastore: Get.find()));    
    Get.lazyReplace<UtilsRepository>(
        () => UtilsRepositoryImplementation(datastore: Get.find()));

    Get.lazyReplace(() => GetSummaryOfDasboardUseCase(repository: Get.find()));
    Get.lazyReplace(() => GetQuotasByDateUseCase(repository: Get.find()));
    Get.lazyReplace(() => PayQuotaUseCase(repository: Get.find()));
    Get.lazyReplace(() => GetLogsUseCase(repository: Get.find()));
  }
}
