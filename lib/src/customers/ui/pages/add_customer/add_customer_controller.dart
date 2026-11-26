import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customer_detail_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_detail/customer_detail_page.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_constants.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_service.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Controller "padre" del formulario de alta.
/// - Guarda el estado compartido (`ui`) que leen y escriben las dos secciones.
/// - Valida ambas secciones, crea el cliente y abre su detalle.
/// La validacion de cada seccion vive en el controller de esa seccion.
class AddCustomerController extends GetxController {
  CreateCustomerUseCase createCustomerUseCase;

  AddCustomerUi ui = AddCustomerUi();

  AddCustomerController({
    required this.createCustomerUseCase,
  });

  /// Primer error encontrado, en el orden en que se ven las secciones.
  String? _validate() =>
      Get.find<AddCustomerPersonalDataController>().validate() ??
      Get.find<AddCustomerManageDataController>().validate();

  void goCreate() async {
    final String? message = _validate();
    if (message != null) {
      _showError(message);
      return;
    }
    bool result = await showDialogWidget(
      context: Get.context!,
      message: areSureToAddCustomer,
    );
    if (result) _execute();
  }

  void _execute() async {
    showLoading();
    final Result<CustomerEntity> resultType =
        await createCustomerUseCase.execute(ui.toRequest());
    hideLoading();
    final data = executeResultUI<CustomerEntity>(resultType);
    if (data == null) return;

    trackEvent(AnalyticsConstants.createCustomerSuccess());
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Éxito');
    // Get.off reemplaza el formulario por el detalle: al volver atras no se
    // regresa al formulario ya enviado, sino a la pantalla que lo abrio.
    Get.off(
      () => CustomerDetailPage(),
      binding: CustomerDetailBinding(),
      arguments: {customerArgument: data},
    );
  }

  void _showError(String message) {
    showSnackbarWidget(
        context: Get.context!, typeSnackbar: TypeSnackbar.error, message: message);
  }
}
