import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/create_customer_use_case.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';
import 'package:utils/utils.dart';

class AddCustomerController extends GetxController {
  GetTypesDocumentUseCase getTypesDocumentUseCase;
  CreateCustomerUseCase createCustomerUseCase;

  List<TypeDocumentEntity> typesDocument = [];
  TypeDocumentEntity? typeDocumentSelected;
  bool isLoading = false;
  CreateCustomerRequest createCustomerRequest = CreateCustomerRequest();
  ValidateResult? validateDocument,
      validateName,
      validateLastname,
      validateAddress;

  AddCustomerController({
    required this.getTypesDocumentUseCase,
    required this.createCustomerUseCase,
  });

  @override
  void onReady() {
    getTypesDocument();
    super.onReady();
  }

  void getTypesDocument() async {
    isLoading = true;
    update([validandoIdGet]);
    ResultType<List<TypeDocumentEntity>, ErrorEntity> resultType =
        await getTypesDocumentUseCase.execute();
    if (resultType is Success) {
      typesDocument = resultType.data as List<TypeDocumentEntity>;
      if(typesDocument.isNotEmpty) onChangedTypeDocument(typesDocument.first.id);
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.title);
    }
    isLoading = false;
    update([validandoIdGet]);
  }

  void onChangedTypeDocument(dynamic value) {
    int index = typesDocument.indexWhere((e) => e.id == value,);
    if(index != notFoundPosition){
      typeDocumentSelected = typesDocument[index];
      createCustomerRequest.idTypeDocument = value;
    }
    update(['typesDocument']);
  }

  void onChangedDocument(String value) {
    validateDocument = validateText(
        rules: {RuleValidator.isRequired: true},
        text: value,
        label: 'Documento');
    if (validateDocument!.hasError.not()) {
      createCustomerRequest.document = validateDocument?.value;
    }
    update();
  }

  void onChangedName(String value) {
    validateName = validateText(
        rules: {RuleValidator.isRequired: true}, text: value, label: 'Nombre');

    if (validateName!.hasError) {
    } else {
      createCustomerRequest.name = validateName?.value;
    }
    update();
  }

  void onChangedLastname(String value) {
    validateLastname = validateText(
        rules: {RuleValidator.isRequired: true},
        text: value,
        label: 'Apellido');

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
        label: 'Dirección');

    if (validateAddress!.hasError) {
    } else {
      createCustomerRequest.address = validateAddress?.value;
      createCustomerRequest;
    }
  }

  void goCreate() async {
    bool result = (await showAlertWidget(
            context: Get.overlayContext!,
            message: '¿Está seguro de agregar el cliente?'))
        .orFalse();
    if (result) {
      create();
    }
  }

  void create() async {
    ResultType<CustomerEntity, ErrorEntity> resultType =
        await createCustomerUseCase.execute(createCustomerRequest);

    if (resultType is Success) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.success,
          message: 'Exito');
      Get.back(result: true);
    }else{
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: 'Ocurrio un error');
    }
  }
}
