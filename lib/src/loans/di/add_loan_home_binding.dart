
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/loan_repository_implementation.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_home/add_loan_home_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_controller.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';

class AddLoanHomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetCustomersUseCase(repository: Get.find()));
    
    Get.lazyPut(() => GetPaymentMethodsUseCase(repository: Get.find()));
    Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());
    Get.lazyPut<UtilsRepository>(() => UtilsRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetPaymentFrequenciesUseCase(repository: Get.find()));
    Get.lazyPut(() => GetPaymentMethodsUseCase(repository: Get.find()));
    Get.lazyReplace(() => AddLoanInformationController(
      getCustomersUseCase: Get.find(),
      getPaymentFrequenciesUseCase: Get.find(),
      getPaymentMethodsUseCase: Get.find(),
    ),);


    Get.lazyPut(() => CreateLoanUseCase(repository: Get.find()));
    Get.lazyPut<LoanDatastore>(() => LoanOnlineDatastore());
    Get.lazyPut<LoanRepository>(() => LoanRepositoryImplementation(datastore: Get.find()));
    Get.lazyReplace(() => AddLoanHomeController(
      createLoanUseCase: Get.find(),
    ),);

    Get.lazyReplace(() => AddLoanQuotasController(
      addLoanRequest: AddLoanRequest(),
    ),);
  }
}