
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';

class AddCustomerBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());
    Get.lazyPut<UtilsRepository>(() => UtilsRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetTypesDocumentUseCase(repository: Get.find()));
    
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => CreateCustomerUseCase(repository: Get.find()));

    Get.lazyReplace(() => AddCustomerController(
      getTypesDocumentUseCase: Get.find(),
      createCustomerUseCase: Get.find(),
    ),);
  }

}