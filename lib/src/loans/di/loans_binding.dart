
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/loan_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_controller.dart';

class LoansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanDatastore>(() => LoanOnlineDatastore());
    Get.lazyPut<LoanRepository>(() => LoanRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetLoansUseCase(repository: Get.find()));

    Get.lazyReplace(() => LoansController(
      getLoansUseCase: Get.find(),
    ),);
  }
}