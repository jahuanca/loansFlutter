
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/loan_repository_implementation.dart';
import 'package:loands_flutter/src/loans/data/repositories/renewal_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/datastores/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_special_loan_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/pay_and_renewal_special_use_case.dart';

class AddSpecialLoanQuotasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanDatastore>(() => LoanOnlineDatastore());
    Get.lazyPut<LoanRepository>(() => LoanRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut<RenewalDataStore>(() => RenewalOnlineDatastore());
    Get.lazyPut<RenewalRepository>(() => RenewalRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut(() => CreateSpecialLoanUseCase(repository: Get.find()));
    Get.lazyPut(() => PayAndRenewalSpecialUseCase(Get.find()));
  }
}