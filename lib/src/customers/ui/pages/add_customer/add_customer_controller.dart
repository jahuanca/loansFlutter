import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/create_customer_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/update_customer_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
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

  List<TypeDocumentEntity> typesDocument = [];
  TypeDocumentEntity? typeDocumentSelected;
  CreateCustomerRequest createCustomerRequest = CreateCustomerRequest();
  ValidateResult? validateDocument,
      validateName,
      validateLastname,
      validateAddress;
  bool isEditing = false;

  AddCustomerController({
    required this.getTypesDocumentUseCase,
    required this.createCustomerUseCase,
    required this.updateCustomerUseCase,
  });

  @override
  void onInit() {
    CustomerEntity? customerEntity = Get.setArgument(customerArgument);
    if (customerEntity != null) {
      isEditing = true;
      
      createCustomerRequest.id = customerEntity.id;
      createCustomerRequest.idTypeDocument = customerEntity.idTypeDocument;

      createCustomerRequest.name = customerEntity.name;
      createCustomerRequest.lastName = customerEntity.lastName;
      createCustomerRequest.document = customerEntity.document;
      createCustomerRequest.address = customerEntity.address;
      onChangedTypeDocument(createCustomerRequest.idTypeDocument);
    }
    super.onInit();
  }

  @override
  void onReady() {
    getTypesDocument();
    super.onReady();
  }

  void getTypesDocument() async {
    showLoading();
    ResultType<List<TypeDocumentEntity>, ErrorEntity> resultType =
        await getTypesDocumentUseCase.execute();
    if (resultType is Success) {
      typesDocument = resultType.data as List<TypeDocumentEntity>;
      if (typesDocument.isNotEmpty) {
        onChangedTypeDocument(typesDocument.first.id);
      }
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.title);
    }
    hideLoading();
  }

  void onChangedTypeDocument(dynamic value) {
    int index = typesDocument.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      typeDocumentSelected = typesDocument[index];
      createCustomerRequest.idTypeDocument = value;
    }
    update([typesDocumentIdGet]);
  }

  void onChangedDocument(String value) {
    validateDocument = validateText(
        rules: {RuleValidator.isRequired: true},
        text: value,
        label: documentString);
    if (validateDocument!.hasError.not()) {
      createCustomerRequest.document = validateDocument?.value;
    }
    update();
  }

  void onChangedName(String value) {
    validateName = validateText(
        rules: {RuleValidator.isRequired: true}, text: value, label: nameString);

    if (validateName!.hasError) {
    } else {
      createCustomerRequest.name = validateName?.value;
    }
    update();
  }

  void onChangedAlias(String value) {
    createCustomerRequest.alias = value;
  }

  void onChangedLastname(String value) {
    validateLastname = validateText(
        rules: {RuleValidator.isRequired: true},
        text: value,
        label: lastNameString);

    if (validateLastname?.hasError ?? false) {
    } else {
      createCustomerRequest.lastName = validateLastname?.value;
    }
    update();
  }

  void onChangedAddress(String value) {
    validateAddress = validateText(
        rules: {RuleValidator.isRequired: true},
        text: value,
        label: addressString);

    if (validateAddress!.hasError) {
    } else {
      createCustomerRequest.address = validateAddress?.value;
      createCustomerRequest;
    }
  }

  String? validate() {
    onChangedDocument(createCustomerRequest.document.orEmpty());
    onChangedName(createCustomerRequest.name.orEmpty());
    onChangedLastname(createCustomerRequest.lastName.orEmpty());
    onChangedAddress(createCustomerRequest.address.orEmpty());
    List<ValidateResult?> allRules = [
      validateDocument,
      validateName,
      validateLastname,
      validateAddress,
    ];
    ValidateResult? firstError = allRules.firstWhereOrNull((e) => e!.hasError.orFalse(),);
    return firstError?.error;
  }

  void goConfirm() async {
    String? message = validate();
    if(message != null) {
      showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.error, 
        message: message
      );
      return;
    }
    bool result = await showDialogWidget(
            context: Get.overlayContext!,
            message: '¿Está seguro de ${isEditing ? 'editar' : 'agregar'} el cliente?');
    if (result) _execute();
  }

  void _execute() async {
    late ResultType<CustomerEntity, ErrorEntity> resultType;

    showLoading();
    if (isEditing) {
      resultType = await updateCustomerUseCase.execute(createCustomerRequest);
    } else {
      resultType = await createCustomerUseCase.execute(createCustomerRequest);
    }
    hideLoading();

    if (resultType is Success) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.success,
          message: 'Exito');
      Get.back(result: true);
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: 'Ocurrio un error');
    }
  }
}
