import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/quota_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/quota_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/datastores/quota_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/quota_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';

class QuotaGroupBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyReplace<QuotaDatastore>(() => QuotaOnlineDatastore());
    Get.lazyReplace<QuotaRepository>(
        () => QuotaRepositoryImplementation(datastore: Get.find()));
    Get.lazyReplace(() => GetAllQuotasUseCase(repository: Get.find()));
  }
}
