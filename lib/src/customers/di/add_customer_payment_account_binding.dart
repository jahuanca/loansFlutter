import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_controller.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_online_datastore.dart';
import 'package:loands_flutter/src/utils/data/repositories/utils_repository_implementation.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_providers_use_case.dart';

/// Formulario de cuenta de pago. Se abre desde el alta de cliente y desde el
/// detalle; si la pantalla anterior ya registro UtilsDatastore/UtilsRepository,
/// lazyPut no los reemplaza y se reutilizan.
class AddCustomerPaymentAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilsDatastore>(() => UtilsOnlineDatastore());
    Get.lazyPut<UtilsRepository>(
        () => UtilsRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => GetPaymentProvidersUseCase(repository: Get.find()));
    Get.lazyPut(() => AddCustomerPaymentAccountController(
          getPaymentProvidersUseCase: Get.find(),
        ));
  }
}
