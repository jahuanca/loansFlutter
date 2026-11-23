import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Paso 2: domicilio. Referencia, foto y ubicacion aun son maqueta:
/// se conectaran a /customer-address en el siguiente paso del plan.
class AddCustomerAddressDataController extends GetxController {
  AddCustomerController addCustomerController;

  AddCustomerAddressDataController({required this.addCustomerController});

  AddCustomerUi get ui => addCustomerController.ui;

  void onChangedAddress(String value) {
    ui.address = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: addressString,
    );
  }

  String? validate() {
    onChangedAddress(ui.address?.value.orEmpty() ?? '');
    return findErrorInValidations([ui.address])?.error;
  }
}
