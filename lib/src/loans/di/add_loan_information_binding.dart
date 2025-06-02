
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';

class AddLoanInformationBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());

    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut<UtilsRepository>(() => UtilsRepositoryImplementation(datastore: Get.find()));
    
    Get.lazyPut(() => GetCustomersUseCase(repository: Get.find()));
    Get.lazyPut(() => GetPaymentMethodsUseCase(repository: Get.find()));
    Get.lazyPut(() => GetPaymentFrequenciesUseCase(repository: Get.find()));
  }
}