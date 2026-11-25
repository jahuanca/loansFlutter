import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_page.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

/// Paso 3: cuentas de pago. La edicion de cada cuenta vive en AddCustomerPaymentAccountPage.
/// Las cuentas se guardan en memoria y, al confirmar, AddCustomerController las crea
/// con su propio servicio (/customer-payment-account) despues de crear el cliente.
/// (Las de un cliente existente se gestionan desde el detalle del cliente.)
class AddCustomerPaymentDataController extends GetxController {
  /// Estado compartido del formulario (el de AddCustomerController, via binding).
  AddCustomerUi ui;

  AddCustomerPaymentDataController({required this.ui});

  void goAddPaymentAccount() async {
    final account = await Get.to<CustomerPaymentAccountEntity>(
        () => AddCustomerPaymentAccountPage());
    if (account == null) return;
    _setLocalDefault(account);
    ui.paymentAccounts.add(account);
    update([paymentAccountsIdGet]);
  }

  void goEditPaymentAccount(int index) async {
    final account = await Get.to<CustomerPaymentAccountEntity>(
        () => AddCustomerPaymentAccountPage(),
        arguments: {customerPaymentAccountArgument: ui.paymentAccounts[index]});
    if (account == null) return;
    _setLocalDefault(account);
    ui.paymentAccounts[index] = account;
    update([paymentAccountsIdGet]);
  }

  void removePaymentAccount(int index) async {
    bool confirm = await showDialogWidget(
        context: Get.context!, message: areSureToDeletePaymentAccount);
    if (!confirm) return;
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
