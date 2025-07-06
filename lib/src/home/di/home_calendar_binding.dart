import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/datastores/summary_online_datastore.dart';
import 'package:loands_flutter/src/home/data/repositories/summary_repository_implementation.dart';
import 'package:loands_flutter/src/home/domain/datastores/summary_datastore.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_summary_of_calendar_use_case.dart';
import 'package:loands_flutter/src/home/domain/use_cases/pay_quota_use_case.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_quotas_by_date_use_case.dart';

class HomeCalendarBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyReplace<SummaryDatastore>(() => SummaryOnlineDatastore());
    Get.lazyReplace<SummaryRepository>(
        () => SummaryRepositoryImplementation(datastore: Get.find()));
    Get.lazyReplace(() => GetSummaryOfCalendarUseCase(repository: Get.find()));
    Get.lazyReplace(() => GetQuotasByDateUseCase(repository: Get.find()));
    Get.lazyReplace(() => PayQuotaUseCase(repository: Get.find()), fenix: true);
  }
}
