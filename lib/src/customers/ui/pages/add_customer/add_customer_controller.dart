import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/create_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/delete_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/get_customer_payment_accounts_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/update_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_page.dart';
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
  GetCustomerPaymentAccountsUseCase getCustomerPaymentAccountsUseCase;
  CreateCustomerPaymentAccountUseCase createCustomerPaymentAccountUseCase;
  UpdateCustomerPaymentAccountUseCase updateCustomerPaymentAccountUseCase;
  DeleteCustomerPaymentAccountUseCase deleteCustomerPaymentAccountUseCase;

  List<TypeDocumentEntity> typesDocument = [];
  List<TypeCustomerEntity> typesCustomer = [];
  List<UserEntity> users = [];
  TypeDocumentEntity? typeDocumentSelected;
  TypeCustomerEntity? typeCustomerSelected;
  UserEntity? recoverySelected;

  AddCustomerUi ui = AddCustomerUi();
  bool isEditing = false;

  AddCustomerController({
    required this.getUsersUseCase,
    required this.getTypesDocumentUseCase,
    required this.createCustomerUseCase,
    required this.updateCustomerUseCase,
    required this.getTypesCustomerUseCase,
    required this.getCustomerPaymentAccountsUseCase,
    required this.createCustomerPaymentAccountUseCase,
    required this.updateCustomerPaymentAccountUseCase,
    required this.deleteCustomerPaymentAccountUseCase,
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
    }
  }

  @override
  void onReady() {
    getTypesDocument();
    getAssignedRecovery(initialValue: ui.idAssignedRecoveryAgent?.value);
    getTypesCustomer(initialValue: ui.idTypeCustomer?.value);
    if (isEditing) getPaymentAccounts();
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

  // ---------------- Cuentas de pago ----------------
  // Cliente nuevo: la lista vive en memoria y viaja en POST /customer/create.
  // Edicion: cada cambio se guarda al momento contra /customer-payment-account.

  void getPaymentAccounts() async {
    final int? idCustomer = ui.id?.value;
    if (idCustomer == null) return;
    Result<List<CustomerPaymentAccountEntity>> result =
        await getCustomerPaymentAccountsUseCase.execute(idCustomer);
    final data = executeResultUI<List<CustomerPaymentAccountEntity>>(result);
    if (data != null) ui.paymentAccounts = data;
    update([paymentAccountsIdGet]);
  }

  void goAddPaymentAccount() async {
    final account = await Get.to<CustomerPaymentAccountEntity>(
        () => AddCustomerPaymentAccountPage());
    if (account == null) return;
    if (isEditing) {
      showLoading();
      final result = await createCustomerPaymentAccountUseCase.execute(
          ui.id!.value!, CustomerPaymentAccountRequest(account));
      hideLoading();
      if (executeResultUI<CustomerPaymentAccountEntity>(result) == null) return;
      getPaymentAccounts(); // recarga: el backend pudo desmarcar la principal anterior
      return;
    }
    _setLocalDefault(account);
    ui.paymentAccounts.add(account);
    update([paymentAccountsIdGet]);
  }

  void goEditPaymentAccount(int index) async {
    final account = await Get.to<CustomerPaymentAccountEntity>(
        () => AddCustomerPaymentAccountPage(),
        arguments: {customerPaymentAccountArgument: ui.paymentAccounts[index]});
    if (account == null) return;
    if (isEditing && account.id != null) {
      showLoading();
      final result = await updateCustomerPaymentAccountUseCase
          .execute(CustomerPaymentAccountRequest(account));
      hideLoading();
      if (executeResultUI<CustomerPaymentAccountEntity>(result) == null) return;
      getPaymentAccounts();
      return;
    }
    _setLocalDefault(account);
    ui.paymentAccounts[index] = account;
    update([paymentAccountsIdGet]);
  }

  void removePaymentAccount(int index) async {
    bool confirm = await showDialogWidget(
        context: Get.context!, message: areSureToDeletePaymentAccount);
    if (!confirm) return;
    final account = ui.paymentAccounts[index];
    if (isEditing && account.id != null) {
      showLoading();
      final result = await deleteCustomerPaymentAccountUseCase.execute(account.id!);
      hideLoading();
      if (executeResultUI<CustomerPaymentAccountEntity>(result) == null) return;
    }
    ui.paymentAccounts.removeAt(index);
    update([paymentAccountsIdGet]);
  }

  /// En memoria replicamos la regla del backend: una sola cuenta principal.
  void _setLocalDefault(CustomerPaymentAccountEntity account) {
    if (!account.isDefault) return;
    for (final other in ui.paymentAccounts) {
      other.isDefault = false;
    }
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
