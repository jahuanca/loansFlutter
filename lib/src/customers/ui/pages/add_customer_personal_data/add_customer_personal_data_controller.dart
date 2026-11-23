import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Paso 1: tipo de documento, documento, alias, nombre, apellido y celular.
class AddCustomerPersonalDataController extends GetxController {
  AddCustomerController addCustomerController;
  GetTypesDocumentUseCase getTypesDocumentUseCase;

  List<TypeDocumentEntity> typesDocument = [];
  TypeDocumentEntity? typeDocumentSelected;

  AddCustomerPersonalDataController({
    required this.addCustomerController,
    required this.getTypesDocumentUseCase,
  });

  AddCustomerUi get ui => addCustomerController.ui;

  @override
  void onReady() {
    getTypesDocument(initialValue: ui.idTypeDocument?.value);
    super.onReady();
  }

  void getTypesDocument({int? initialValue}) async {
    showLoading();
    Result<List<TypeDocumentEntity>> resultType =
        await getTypesDocumentUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<TypeDocumentEntity>>(resultType);
    if (data != null) {
      typesDocument = data;
      if (typesDocument.isNotEmpty) {
        // En edicion se respeta el tipo guardado del cliente.
        onChangedTypeDocument(initialValue ?? typesDocument.first.id);
      }
    }
    update([typesDocumentIdGet]);
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

  void onChangedDocument(String value) {
    ui.document = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: documentString,
    );
  }

  void onChangedAlias(String value) {
    ui.alias = ValidateResult.initialize(
      label: aliasString,
      value: value,
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

  void onChangedLastname(String value) {
    ui.lastName = validateText<String>(
      rules: {RuleValidator.isRequired: true},
      text: value,
      label: lastNameString,
    );
    update();
  }

  void onChangedPhone(String value) {
    ui.phone = validateText<String>(
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.minLength: 9,
        RuleValidator.maxLength: 9,
      },
      text: value,
      label: phoneString,
    );
  }

  /// Devuelve el primer error del paso, o null si todo es valido.
  String? validate() {
    // `?.` + orEmpty: si el usuario nunca escribio en un campo, su ValidateResult es null.
    onChangedDocument(ui.document?.value.orEmpty() ?? '');
    onChangedName(ui.name?.value.orEmpty() ?? '');
    onChangedLastname(ui.lastName?.value.orEmpty() ?? '');
    onChangedPhone(ui.phone?.value.orEmpty() ?? '');
    return findErrorInValidations([
      ui.idTypeDocument,
      ui.document,
      ui.alias,
      ui.name,
      ui.lastName,
      ui.phone,
    ])?.error;
  }
}
