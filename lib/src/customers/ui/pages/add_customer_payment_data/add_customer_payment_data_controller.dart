import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/create_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/delete_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/get_customer_payment_accounts_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_payment_account/update_customer_payment_account_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_page.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Paso 3: cuentas de pago. La edicion de cada cuenta vive en AddCustomerPaymentAccountPage.
/// En alta se guardan en memoria y viajan con el create; en edicion se guardan
/// directo contra /customer-payment-account.
class AddCustomerPaymentDataController extends GetxController {
  AddCustomerController addCustomerController;
  GetCustomerPaymentAccountsUseCase getCustomerPaymentAccountsUseCase;
  CreateCustomerPaymentAccountUseCase createCustomerPaymentAccountUseCase;
  UpdateCustomerPaymentAccountUseCase updateCustomerPaymentAccountUseCase;
  DeleteCustomerPaymentAccountUseCase deleteCustomerPaymentAccountUseCase;

  AddCustomerPaymentDataController({
    required this.addCustomerController,
    required this.getCustomerPaymentAccountsUseCase,
    required this.createCustomerPaymentAccountUseCase,
    required this.updateCustomerPaymentAccountUseCase,
    required this.deleteCustomerPaymentAccountUseCase,
  });

  AddCustomerUi get ui => addCustomerController.ui;
  bool get isEditing => addCustomerController.isEditing;

  @override
  void onReady() {
    if (isEditing) getPaymentAccounts();
    super.onReady();
  }

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

  /// Las cuentas de pago son opcionales: este paso no bloquea el avance.
  String? validate() => null;
}
