import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_payment_account_binding.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/di/edit_customer_address_binding.dart';
import 'package:loands_flutter/src/customers/di/edit_customer_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/get_customer_addresses_use_case.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/create_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/delete_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_page.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/get_customer_payment_accounts_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/type_customer/get_types_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_section_enum.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer_address/edit_customer_address_page.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_types_document_use_case.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Detalle del cliente por secciones. Cada seccion se edita en su propia pantalla
/// y al volver solo se refresca lo que cambio.
class CustomerDetailController extends GetxController {
  GetCustomerAddressesUseCase getCustomerAddressesUseCase;
  GetCustomerPaymentAccountsUseCase getCustomerPaymentAccountsUseCase;
  CreateCustomerPaymentAccountUseCase createCustomerPaymentAccountUseCase;
  DeleteCustomerPaymentAccountUseCase deleteCustomerPaymentAccountUseCase;
  GetTypesDocumentUseCase getTypesDocumentUseCase;
  GetTypesCustomerUseCase getTypesCustomerUseCase;
  GetUsersUseCase getUsersUseCase;

  late CustomerEntity customer;
  List<CustomerAddressEntity> addresses = [];
  List<CustomerPaymentAccountEntity> paymentAccounts = [];

  // Catalogos: el cliente solo trae ids (idTypeDocument, idTypeCustomer, idAssignedRecoveryAgent).
  List<TypeDocumentEntity> typesDocument = [];
  List<TypeCustomerEntity> typesCustomer = [];
  List<UserEntity> users = [];

  /// Si se edito el cliente, se devuelve a la lista al salir para que se actualice.
  bool hasChanges = false;

  CustomerDetailController({
    required this.getCustomerAddressesUseCase,
    required this.getCustomerPaymentAccountsUseCase,
    required this.createCustomerPaymentAccountUseCase,
    required this.deleteCustomerPaymentAccountUseCase,
    required this.getTypesDocumentUseCase,
    required this.getTypesCustomerUseCase,
    required this.getUsersUseCase,
  });

  @override
  void onInit() {
    customer = Get.setArgument(customerArgument);
    super.onInit();
  }

  @override
  void onReady() {
    loadAll();
    super.onReady();
  }

  Future<void> loadAll() async {
    showLoading();
    // Las consultas no dependen entre si: se lanzan en paralelo.
    await Future.wait<void>([
      _getAddresses(),
      _getPaymentAccounts(),
      _getTypesDocument(),
      _getTypesCustomer(),
      _getUsers(),
    ]);
    hideLoading();
    update([pageIdGet]);
  }

  Future<void> _getAddresses() async {
    final result = await getCustomerAddressesUseCase.execute(customer.id);
    addresses = executeResultUI<List<CustomerAddressEntity>>(result) ?? addresses;
  }

  Future<void> _getPaymentAccounts() async {
    final result = await getCustomerPaymentAccountsUseCase.execute(customer.id);
    paymentAccounts =
        executeResultUI<List<CustomerPaymentAccountEntity>>(result) ?? paymentAccounts;
  }

  Future<void> _getTypesDocument() async {
    final result = await getTypesDocumentUseCase.execute();
    typesDocument = executeResultUI<List<TypeDocumentEntity>>(result) ?? typesDocument;
  }

  Future<void> _getTypesCustomer() async {
    final result = await getTypesCustomerUseCase.execute();
    typesCustomer = executeResultUI<List<TypeCustomerEntity>>(result) ?? typesCustomer;
  }

  Future<void> _getUsers() async {
    final result = await getUsersUseCase.execute();
    users = executeResultUI<List<UserEntity>>(result) ?? users;
  }

  // ---------------- Textos de la seccion Tipo / Informacion personal ----------------

  String get typeDocumentName =>
      typesDocument.firstWhereOrNull((e) => e.id == customer.idTypeDocument)?.name ??
      withoutDataString;

  String get typeCustomerName =>
      typesCustomer.firstWhereOrNull((e) => e.id == customer.idTypeCustomer)?.name ??
      withoutDataString;

  String get recoveryAgentName =>
      users.firstWhereOrNull((e) => e.id == customer.idAssignedRecoveryAgent)?.fullName ??
      withoutDataString;

  // ---------------- Informacion personal y Tipo ----------------

  void goEditPersonalData() => _goEditCustomer(EditCustomerSection.personalData);

  void goEditManageData() => _goEditCustomer(EditCustomerSection.manageData);

  void _goEditCustomer(EditCustomerSection section) async {
    final CustomerEntity? result = await Get.to<CustomerEntity>(
      () => EditCustomerPage(),
      binding: EditCustomerBinding(customer: customer, section: section),
    );
    if (result == null) return;
    customer = result;
    hasChanges = true;
    update([pageIdGet]);
  }

  // ---------------- Direcciones ----------------

  void goAddAddress() => _goAddressForm();

  void goEditAddress(CustomerAddressEntity address) => _goAddressForm(address: address);

  /// Mismo formulario para crear (sin address) y editar.
  void _goAddressForm({CustomerAddressEntity? address}) async {
    final CustomerAddressEntity? result = await Get.to<CustomerAddressEntity>(
      () => EditCustomerAddressPage(),
      binding: EditCustomerAddressBinding(
        idCustomer: customer.id,
        address: address,
        isFirstAddress: addresses.isEmpty,
      ),
    );
    if (result == null) return;
    // Se recarga la lista: si se marco como principal, el backend desmarco la anterior.
    showLoading();
    await _getAddresses();
    hideLoading();
    update([addressesIdGet]);
  }

  void goToMap(CustomerAddressEntity address) {
    openMap(
      latitude: address.latitude,
      longitude: address.longitude,
      address: address.address,
    );
  }

  // ---------------- Cuentas de pago ----------------

  /// Reutiliza el formulario de cuenta del alta (devuelve la cuenta sin guardar)
  /// y aqui se guarda contra /customer-payment-account/create.
  void goAddPaymentAccount() async {
    final CustomerPaymentAccountEntity? account =
        await Get.to<CustomerPaymentAccountEntity>(() => AddCustomerPaymentAccountPage(),
            binding: AddCustomerPaymentAccountBinding());
    if (account == null) return;
    showLoading();
    final result = await createCustomerPaymentAccountUseCase.execute(
        customer.id, CustomerPaymentAccountRequest(account));
    if (executeResultUI<CustomerPaymentAccountEntity>(result) != null) {
      // Se recarga: si la nueva es principal, el backend desmarco la anterior.
      await _getPaymentAccounts();
    }
    hideLoading();
    update([paymentAccountsIdGet]);
  }

  void deletePaymentAccount(CustomerPaymentAccountEntity account) async {
    final int? id = account.id;
    if (id == null) return;
    final bool confirm = await showDialogWidget(
        context: Get.context!, message: areSureToDeletePaymentAccount);
    if (!confirm) return;
    showLoading();
    final result = await deleteCustomerPaymentAccountUseCase.execute(id);
    hideLoading();
    if (executeResultUI<CustomerPaymentAccountEntity>(result) == null) return;
    paymentAccounts.removeWhere((e) => e.id == id);
    update([paymentAccountsIdGet]);
  }

  // ---------------- Salida ----------------

  void goBack() => Get.back(result: hasChanges ? customer : null);
}
