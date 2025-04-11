
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetCustomersUseCase(repository: Get.find()));

    Get.lazyPut(() => CustomersController(
      getCustomersUseCase: Get.find()
    ));
  }

}