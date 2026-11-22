
import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_online_datastore.dart';
import 'package:loands_flutter/src/chats/data/repositories/user_repository_implementation.dart';
import 'package:loands_flutter/src/chats/domain/repositories/user_repository.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_payment_account/customer_payment_account_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_payment_account/customer_payment_account_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_payment_account_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_payment_account_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/create_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/delete_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/get_customer_payment_accounts_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/update_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/data/datastores/type_customer/type_customer_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/data/repositories/type_customer_repository_implementation.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/type_customer/type_customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/repositories/type_customer_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/type_customer/get_types_customer_use_case.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';

class AddCustomerBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());
    Get.lazyPut<UtilsRepository>(() => UtilsRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetTypesDocumentUseCase(repository: Get.find()));
    
    Get.lazyPut<CustomerDatastore>(() => CustomerOnlineDatastore());
    Get.lazyPut<TypeCustomerDatastore>(() => TypeCustomerOnlineDatastore());
    Get.lazyPut<UserDatastore>(() => UserOnlineDatastore());

    Get.lazyPut<CustomerRepository>(() => CustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut<TypeCustomerRepository>(() => TypeCustomerRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut<UserRepository>(() => UserRepositoryImplementation(Get.find()));

    Get.lazyPut(() => CreateCustomerUseCase(repository: Get.find()));
    Get.lazyPut(() => UpdateCustomerUseCase(repository: Get.find()));
    Get.lazyPut(() => GetTypesCustomerUseCase(Get.find()));
    Get.lazyPut(() => GetUsersUseCase(Get.find()));

    // Cuentas de pago: en edicion se guardan directo contra /customer-payment-account
    Get.lazyPut<CustomerPaymentAccountDatastore>(() => CustomerPaymentAccountOnlineDatastore());
    Get.lazyPut<CustomerPaymentAccountRepository>(
        () => CustomerPaymentAccountRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetCustomerPaymentAccountsUseCase(repository: Get.find()));
    Get.lazyPut(() => CreateCustomerPaymentAccountUseCase(repository: Get.find()));
    Get.lazyPut(() => UpdateCustomerPaymentAccountUseCase(repository: Get.find()));
    Get.lazyPut(() => DeleteCustomerPaymentAccountUseCase(repository: Get.find()));
  }

}