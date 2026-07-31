import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/update_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/type_customer/get_types_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_constants.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_service.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';
import 'package:utils/utils.dart';

class AddCustomerController extends GetxController {
  GetTypesDocumentUseCase getTypesDocumentUseCase;
  CreateCustomerUseCase createCustomerUseCase;
  UpdateCustomerUseCase updateCustomerUseCase;
  GetTypesCustomerUseCase getTypesCustomerUseCase;

  List<TypeDocumentEntity> typesDocument = [];
  List<TypeCustomerEntity> typesCustomer = [];
  TypeDocumentEntity? typeDocumentSelected;
  TypeCustomerEntity? typeCustomerSelected;

  AddCustomerUi ui = AddCustomerUi();
  bool isEditing = false;

  AddCustomerController({
    required this.getTypesDocumentUseCase,
    required this.createCustomerUseCase,
    required this.updateCustomerUseCase,
    required this.getTypesCustomerUseCase,
  });

  @override
  void onInit() {
    setInitialValues();
    super.onInit();
  }

  void setInitialValues() {
    CustomerEntity? customerEntity = Get.setArgument(customerArgument);
    if (customerEntity != null) {
      isEditing = true;

      ui.setValuesOfCustomer(customerEntity);
      onChangedTypeDocument(ui.idTypeDocument?.value);
      onChangedTypeCustomer(ui.idTypeCustomer?.value);
    }
  }

  @override
  void onReady() {
    getTypesDocument();
    getTypesCustomer(initialValue: ui.idTypeCustomer?.value);
    super.onReady();
  }

  void getTypesDocument() async {
    showLoading();
    Result<List<TypeDocumentEntity>> resultType =
        await getTypesDocumentUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<TypeDocumentEntity>>(resultType);
    if (data != null) {
      typesDocument = data;
      if (typesDocument.isNotEmpty) {
        onChangedTypeDocument(typesDocument.first.id);
      }
    }
  }

  void getTypesCustomer({int? initialValue}) async {
    showLoading();
    Result<List<TypeCustomerEntity>> resultType =
        await getTypesCustomerUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<TypeCustomerEntity>>(resultType);
    if (data != null) {
      typesCustomer = data;
      if (typesCustomer.isNotEmpty) {
        onChangedTypeCustomer(initialValue ?? typesCustomer.first.id);
      }
    }
  }

  void onChangedTypeDocument(dynamic value) {
    int index = typesDocument.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      typeDocumentSelected = typesDocument[index];
      ui.idTypeDocument = ValidateResult.initialize(
        label: typeDocumentString,
        value: value,
      );
    }
    update([typesDocumentIdGet]);
  }

  void onChangedTypeCustomer(dynamic value) {
    int index = typesCustomer.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      typeCustomerSelected = typesCustomer[index];
      ui.idTypeCustomer = ValidateResult.initialize(
        label: typeCustomerString,
        value: value,
      );
    }
    update([typesCustomerIdGet]);
  }

  void onChangedDocument(String value) {
    ui.document = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: documentString,
    );
  }

  void onChangedName(String value) {
    ui.name = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: nameString,
    );
    update();
  }

  void onChangedAlias(String value) {
    ui.alias = ValidateResult.initialize(
      label: aliasString,
      value: value,
    );
  }

  void onChangedLastname(String value) {
    ui.lastName = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: lastNameString,
    );
    update();
  }

  void onChangedAddress(String value) {
    ui.address = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: addressString,
    );
  }

  String? validate() {
    onChangedDocument(ui.document!.value.orEmpty());
    onChangedName(ui.name!.value.orEmpty());
    onChangedLastname(ui.lastName!.value.orEmpty());
    onChangedAddress(ui.address!.value.orEmpty());
    return ui.validate()?.error;
  }

  void goConfirm() async {
    String? message = validate();
    if (message != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
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
          message: 'Exito');
      Get.back(result: data);
    }
  }
}
