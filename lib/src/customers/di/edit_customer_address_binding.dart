import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_address/customer_address_datastore.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer_address/customer_address_online_datastore.dart';
import 'package:loands_flutter/src/customers/data/repositories/customer_address_repository_implementation.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_address_repository.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/create_customer_address_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/update_customer_address_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/upload_customer_address_image_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer_address/edit_customer_address_controller.dart';

/// Sin `address` el formulario crea; con `address` la edita.
class EditCustomerAddressBinding extends Bindings {
  final int idCustomer;
  final CustomerAddressEntity? address;
  final bool isFirstAddress;

  EditCustomerAddressBinding({
    required this.idCustomer,
    this.address,
    this.isFirstAddress = false,
  });

  @override
  void dependencies() {
    Get.lazyPut<CustomerAddressDatastore>(() => CustomerAddressOnlineDatastore());
    Get.lazyPut<CustomerAddressRepository>(
        () => CustomerAddressRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => CreateCustomerAddressUseCase(repository: Get.find()));
    Get.lazyPut(() => UpdateCustomerAddressUseCase(repository: Get.find()));
    Get.lazyPut(() => UploadCustomerAddressImageUseCase(repository: Get.find()));
    Get.lazyPut(() => EditCustomerAddressController(
          createCustomerAddressUseCase: Get.find(),
          updateCustomerAddressUseCase: Get.find(),
          uploadCustomerAddressImageUseCase: Get.find(),
          idCustomer: idCustomer,
          original: address,
          isFirstAddress: isFirstAddress,
        ));
  }
}
