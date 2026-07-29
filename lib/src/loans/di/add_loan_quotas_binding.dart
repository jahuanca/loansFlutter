
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_offline_datastore.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal/renewal_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/loan_repository_implementation.dart';
import 'package:loands_flutter/src/loans/data/repositories/renewal_repository_implementation.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_loan_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/pay_and_renewal_use_case.dart';

class AddLoanQuotasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateLoanUseCase(repository: Get.find()));
    Get.lazyPut(() => PayAndRenewalUseCase(Get.find()));

    Get.lazyPut<RenewalDataStore>(() => RenewalOnlineDatastore());
    Get.lazyPut<LoanOnlineDatastore>(() => LoanOnlineDatastore());
    Get.lazyPut<LoanOfflineDatastore>(() => LoanOfflineDatastore());
    Get.lazyPut<LoanRepository>(() => LoanRepositoryImplementation(
      onlineDatastore: Get.find(),
      offlineDatastore: Get.find(),
    ));
    Get.lazyPut<RenewalRepository>(() => RenewalRepositoryImplementation(datastore: Get.find()));
  }
}