import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_provider_entity.dart';
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
  GetUsersUseCase getUsersUseCase;

  List<TypeDocumentEntity> typesDocument = [];
  List<TypeCustomerEntity> typesCustomer = [];
  List<UserEntity> users = [];
  List<PaymentProviderEntity> paymentProviders = PaymentProviderEntity.defaults;
  TypeDocumentEntity? typeDocumentSelected;
  TypeCustomerEntity? typeCustomerSelected;
  UserEntity? recoverySelected;
  PaymentProviderEntity? paymentProviderSelected;

  AddCustomerUi ui = AddCustomerUi();
  bool isEditing = false;

  AddCustomerController({
    required this.getUsersUseCase,
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
      onChangedAssignedRecovery(ui.idAssignedRecoveryAgent?.value);
      onChangedPaymentProvider(ui.idPaymentProvider?.value);
    }
  }

  @override
  void onReady() {
    getTypesDocument();
    getAssignedRecovery(initialValue: ui.idAssignedRecoveryAgent?.value);
    getTypesCustomer(initialValue: ui.idTypeCustomer?.value);
    super.onReady();
  }

  void getAssignedRecovery({int? initialValue}) async {
    showLoading();
    Result<List<UserEntity>> resultType =
        await getUsersUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<UserEntity>>(resultType);
    if (data != null) {
      users = data;
      if (initialValue != null) {
        onChangedAssignedRecovery(initialValue);
      }
    }
     update([assignedRecoveryIdGet]);
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
    update([typesCustomerIdGet]);
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

  void onChangedAssignedRecovery(dynamic value) {
    int index = users.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      recoverySelected = users[index];
      ui.idAssignedRecoveryAgent = ValidateResult.initialize(
        label: assignedRecoveryAgentString,
        value: value,
      );
    }
    update([assignedRecoveryIdGet]);
  }

  void onChangedPaymentProvider(dynamic value) {
    int index = paymentProviders.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      paymentProviderSelected = paymentProviders[index];
      ui.idPaymentProvider = ValidateResult.initialize(
        label: paymentProviderString,
        value: value,
      );
    }
    update([paymentProvidersIdGet]);
  }

  void onChangedAccountNumber(String value) {
    ui.accountNumber = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfAccountNumber,
      },
      text: value,
      label: accountNumberString,
    );
  }

  void onChangedCci(String value) {
    ui.cci = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfCci,
      },
      text: value,
      label: cciString,
    );
  }

  void onChangedPaymentPhone(String value) {
    ui.paymentPhone = validateText<String>(
      rules: {
        if (value.isNotEmpty)
          RuleValidator.minLength: CustomerPaymentAccountEntity.maxLengthOfPhone,
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfPhone,
      },
      text: value,
      label: paymentPhoneString,
    );
  }

  void onChangedHolderName(String value) {
    ui.holderName = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfHolderName,
      },
      text: value,
      label: holderNameString,
    );
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
    onChangedPhone(ui.phone!.value.orEmpty());
    onChangedAccountNumber(ui.accountNumber?.value ?? '');
    onChangedCci(ui.cci?.value ?? '');
    onChangedPaymentPhone(ui.paymentPhone?.value ?? '');
    onChangedHolderName(ui.holderName?.value ?? '');
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
          message: 'Éxito');
      Get.back(result: data);
    }
  }
}
