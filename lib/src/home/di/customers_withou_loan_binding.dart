import 'package:get/instance_manager.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_customer_without_loan_use_case.dart';

class CustomersWithouLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<CustomerRepository>(
        () => CustomerRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut(() => GetCustomerWithoutLoanUseCase(Get.find()));
  }
}
