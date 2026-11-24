import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_manage_data_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_personal_data_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_section_enum.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Edita una seccion del cliente. Los campos y su validacion son los del paso del alta
/// (AddCustomerPersonalDataController / AddCustomerManageDataController); este controller
/// solo guarda. Cada seccion tiene su endpoint (/customer/update-personal-data y
/// /customer/update-manage-data) que recibe solo los campos de esa seccion.
class EditCustomerController extends GetxController {
  UpdateCustomerPersonalDataUseCase updateCustomerPersonalDataUseCase;
  UpdateCustomerManageDataUseCase updateCustomerManageDataUseCase;
  AddCustomerUi ui;
  EditCustomerSection section;

  EditCustomerController({
    required this.updateCustomerPersonalDataUseCase,
    required this.updateCustomerManageDataUseCase,
    required this.ui,
    required this.section,
  });

  String? _validate() => switch (section) {
        EditCustomerSection.personalData =>
          Get.find<AddCustomerPersonalDataController>().validate(),
        EditCustomerSection.manageData =>
          Get.find<AddCustomerManageDataController>().validate(),
      };

  Future<Result<CustomerEntity>> _update() => switch (section) {
        EditCustomerSection.personalData =>
          updateCustomerPersonalDataUseCase.execute(ui.toPersonalDataRequest()),
        EditCustomerSection.manageData =>
          updateCustomerManageDataUseCase.execute(ui.toManageDataRequest()),
      };

  void save() async {
    final String? message = _validate();
    if (message != null) {
      showSnackbarWidget(
          context: Get.context!, typeSnackbar: TypeSnackbar.error, message: message);
      return;
    }
    final bool confirm = await showDialogWidget(
        context: Get.context!, message: areSureToEditCustomer);
    if (!confirm) return;

    showLoading();
    final Result<CustomerEntity> result = await _update();
    hideLoading();
    final CustomerEntity? data = executeResultUI<CustomerEntity>(result);
    if (data != null) Get.back(result: data);
  }
}
