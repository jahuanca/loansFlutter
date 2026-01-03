import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/quota_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/quota_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/datastores/quota_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/quota_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_controller.dart';

class LoanDetailBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<QuotaDatastore>(
      () => QuotaOnlineDatastore(),
    );
    Get.lazyPut<QuotaRepository>(
      () => QuotaRepositoryImplementation(datastore: Get.find()),
    );
    Get.lazyPut<GetAllQuotasUseCase>(
      () => GetAllQuotasUseCase(repository: Get.find()),
    );

    Get.lazyPut(() => LoanDetailController(
          getAllQuotasUseCase: Get.find(),
        ));
  }
}
