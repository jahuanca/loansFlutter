
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_offline_datastore.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/loan_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';

class LoansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanOnlineDatastore>(() => LoanOnlineDatastore());
    Get.lazyPut<LoanOfflineDatastore>(() => LoanOfflineDatastore());
    Get.lazyPut<LoanRepository>(() => LoanRepositoryImplementation(
      onlineDatastore: Get.find(),
      offlineDatastore: Get.find(),
    ));
    Get.lazyPut(() => GetLoansUseCase(repository: Get.find()));
  }
}