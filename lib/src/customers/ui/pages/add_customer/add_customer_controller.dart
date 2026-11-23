import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_step_enum.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_address_data/add_customer_address_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_data/add_customer_payment_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_controller.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_constants.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Controller "padre" del formulario por pasos.
/// - Guarda el estado compartido (`ui`) que leen y escriben los 4 pasos.
/// - Maneja la navegacion del PageView y el envio final (un solo create/update).
/// La validacion de cada paso vive en el controller de ese paso.
class AddCustomerController extends GetxController {
  CreateCustomerUseCase createCustomerUseCase;
  UpdateCustomerUseCase updateCustomerUseCase;

  AddCustomerUi ui = AddCustomerUi();
  bool isEditing = false;

  final PageController pageController = PageController();
  final List<AddCustomerStep> steps = AddCustomerStep.values;
  int currentStep = 0;

  AddCustomerController({
    required this.createCustomerUseCase,
    required this.updateCustomerUseCase,
  });

  AddCustomerStep get currentStepType => steps[currentStep];
  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == steps.length - 1;

  @override
  void onInit() {
    setInitialValues();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void setInitialValues() {
    CustomerEntity? customerEntity = Get.setArgument(customerArgument);
    if (customerEntity != null) {
      isEditing = true;
      ui.setValuesOfCustomer(customerEntity);
    }
  }

  // ---------------- Navegacion entre pasos ----------------

  void goNextStep() {
    String? message = _validateStep(currentStepType);
    if (message != null) {
      _showError(message);
      return;
    }
    if (isLastStep) {
      goConfirm();
      return;
    }
    _goToStep(currentStep + 1);
  }

  void goPreviousStep() {
    if (isFirstStep) return;
    _goToStep(currentStep - 1);
  }

  /// Boton atras del sistema: si no estamos en el primer paso, retrocede un paso.
  void onPopInvoked(bool didPop) {
    if (didPop) return;
    goPreviousStep();
  }

  void _goToStep(int index) {
    currentStep = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update([pageIdGet]);
  }

  // Cada paso valida sus propios campos.
  String? _validateStep(AddCustomerStep step) => switch (step) {
        AddCustomerStep.personalData =>
          Get.find<AddCustomerPersonalDataController>().validate(),
        AddCustomerStep.addressData =>
          Get.find<AddCustomerAddressDataController>().validate(),
        AddCustomerStep.paymentData =>
          Get.find<AddCustomerPaymentDataController>().validate(),
        AddCustomerStep.manageData =>
          Get.find<AddCustomerManageDataController>().validate(),
      };

  // ---------------- Envio final ----------------

  void goConfirm() async {
    // Se revalidan todos los pasos: si alguno falla, se lleva al usuario a ese paso.
    for (int i = 0; i < steps.length; i++) {
      String? message = _validateStep(steps[i]);
      if (message != null) {
        _goToStep(i);
        _showError(message);
        return;
      }
    }
    bool result = await showDialogWidget(
      context: Get.context!,
      message: (isEditing) ? areSureToEditCustomer : areSureToAddCustomer,
    );
    if (result) _execute();
  }

  void _execute() async {
    late Result<CustomerEntity> resultType;
    showLoading();
    if (isEditing) {
      resultType = await updateCustomerUseCase.execute(ui.toRequest());
    } else {
      resultType = await createCustomerUseCase.execute(ui.toRequest());
    }
    hideLoading();
    final data = executeResultUI<CustomerEntity>(resultType);
    if (data != null) {
      trackEvent(AnalyticsConstants.createCustomerSuccess());
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.success,
          message: 'Éxito');
      Get.back(result: data);
    }
  }

  void _showError(String message) {
    showSnackbarWidget(
        context: Get.context!, typeSnackbar: TypeSnackbar.error, message: message);
  }
}
