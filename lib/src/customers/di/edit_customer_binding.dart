import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_online_datastore.dart';
import 'package:loands_flutter/src/chats/data/repositories/user_repository_implementation.dart';
import 'package:loands_flutter/src/chats/domain/repositories/user_repository.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/type_customer/type_customer_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/type_customer/type_customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/data/repositories/type_customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/repositories/type_customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_manage_data_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_personal_data_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/type_customer/get_types_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_section_enum.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';

/// Recibe el cliente por constructor (no por Get.arguments): asi el `ui` ya esta cargado
/// cuando se crean los controllers, sin depender del orden en que GetX fija los argumentos.
class EditCustomerBinding extends Bindings {
  final CustomerEntity customer;
  final EditCustomerSection section;

  EditCustomerBinding({required this.customer, required this.section});

  @override
  void dependencies() {
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<CustomerRepository>(
        () => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => UpdateCustomerPersonalDataUseCase(repository: Get.find()));
    Get.lazyPut(() => UpdateCustomerManageDataUseCase(repository: Get.find()));

    final AddCustomerUi ui = AddCustomerUi()..setValuesOfCustomer(customer);

    // Solo se registra el controller de la seccion que se edita (cada uno carga sus catalogos).
    switch (section) {
      case EditCustomerSection.personalData:
        Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());
        Get.lazyPut<UtilsRepository>(
            () => UtilsRepositoryImplementation(datastore: Get.find()));
        Get.lazyPut(() => GetTypesDocumentUseCase(repository: Get.find()));
        Get.put(AddCustomerPersonalDataController(
          ui: ui,
          getTypesDocumentUseCase: Get.find(),
        ));
      case EditCustomerSection.manageData:
        Get.lazyPut<TypeCustomerDatastore>(() => TypeCustomerOnlineDatastore());
        Get.lazyPut<TypeCustomerRepository>(
            () => TypeCustomerRepositoryImplementation(datastore: Get.find()));
        Get.lazyPut(() => GetTypesCustomerUseCase(Get.find()));
        Get.lazyPut<UserDatastore>(() => UserOnlineDatastore());
        Get.lazyPut<UserRepository>(() => UserRepositoryImplementation(Get.find()));
        Get.lazyPut(() => GetUsersUseCase(Get.find()));
        Get.put(AddCustomerManageDataController(
          ui: ui,
          getTypesCustomerUseCase: Get.find(),
          getUsersUseCase: Get.find(),
        ));
    }

    Get.put(EditCustomerController(
      updateCustomerPersonalDataUseCase: Get.find(),
      updateCustomerManageDataUseCase: Get.find(),
      ui: ui,
      section: section,
    ));
  }
}
