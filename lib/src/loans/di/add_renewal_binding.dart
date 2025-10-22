
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/repositories/renewal_repository_implementation.dart';
import 'package:loands_flutter/src/loans/domain/datastores/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/add_renewal_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_metadata_renewal_use_case.dart';

class AddRenewalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RenewalDataStore>(() => RenewalOnlineDatastore());
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());

    Get.lazyPut<RenewalRepository>(() => RenewalRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut(() => GetCustomersUseCase(repository: Get.find()));
    Get.lazyPut(() => GetMetadataRenewalUseCase(Get.find()));
    Get.lazyPut(() => AddRenewalUseCase(repository: Get.find()));
  }

}