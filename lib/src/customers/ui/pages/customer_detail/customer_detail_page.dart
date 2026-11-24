import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_detail/customer_detail_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Detalle del cliente en 4 secciones: informacion personal, direcciones,
/// cuentas de pago y tipo. Cada seccion tiene sus propias acciones.
class CustomerDetailPage extends StatelessWidget {
  CustomerDetailPage({super.key});

  final CustomerDetailController controller = Get.find<CustomerDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDetailController>(
      id: pageIdGet,
      builder: (controller) => PopScope(
        // Se intercepta el "atras" para devolver el cliente editado a la lista.
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.goBack();
        },
        child: Scaffold(
          appBar: appBarWidget(text: customerDetailString, hasArrowBack: true),
          body: RefreshIndicator(
            onRefresh: controller.loadAll,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _header(),
                _personalInformationSection(),
                _addressesSection(),
                _paymentAccountsSection(),
                _typeSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final customer = controller.customer;
    final String initial =
        customer.aliasOrFullName.isEmpty ? '?' : customer.aliasOrFullName[0].toUpperCase();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: primaryColor,
            child: Text(
              initial,
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            customer.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (customer.alias != null) Text(customer.alias!),
        ],
      ),
    );
  }

  // ---------------- 1. Informacion personal ----------------

  Widget _personalInformationSection() {
    final customer = controller.customer;
    return _section(
      title: personalInformationString,
      onEdit: controller.goEditPersonalData,
      children: [
        _infoRow(typeDocumentString, controller.typeDocumentName),
        _infoRow(documentString, customer.document),
        _infoRow(aliasString, customer.alias ?? withoutDataString),
        _infoRow(nameString, customer.name),
        _infoRow(lastNameString, customer.lastName),
        _infoRow(phoneString, customer.phone ?? withoutDataString),
      ],
    );
  }

  // ---------------- 2. Direcciones ----------------

  Widget _addressesSection() {
    return GetBuilder<CustomerDetailController>(
      id: addressesIdGet,
      builder: (controller) => _section(
        title: addressesString,
        children: [
          if (controller.addresses.isEmpty) ...[
            const Text(noAddressesString),
            _addButton(addAddressString, controller.goAddAddress),
          ],
          ...controller.addresses.map(_addressTile),
        ],
      ),
    );
  }

  Widget _addressTile(CustomerAddressEntity address) {
    final CustomerAddressType type = address.typeOfAddress;
    final String title =
        address.isPrimary ? '${type.label} · $primaryString' : type.label;
    final String? reference = address.reference;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(_iconOfAddressType(type), color: primaryColor),
      title: Text(title),
      subtitle: Text(
        reference == null ? address.address : '${address.address}\n$reference',
      ),
      isThreeLine: reference != null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: editAddressString,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => controller.goEditAddress(address),
          ),
          IconButton(
            tooltip: viewOnMapString,
            icon: const Icon(Icons.map_outlined),
            onPressed: () => controller.goToMap(address),
          ),
        ],
      ),
    );
  }

  IconData _iconOfAddressType(CustomerAddressType type) => switch (type) {
        CustomerAddressType.home => Icons.home_outlined,
        CustomerAddressType.business => Icons.storefront_outlined,
        CustomerAddressType.family => Icons.family_restroom,
        CustomerAddressType.other => Icons.place_outlined,
      };

  // ---------------- 3. Cuentas de pago ----------------

  Widget _paymentAccountsSection() {
    return GetBuilder<CustomerDetailController>(
      id: paymentAccountsIdGet,
      builder: (controller) => _section(
        title: paymentAccountsString,
        children: [
          if (controller.paymentAccounts.isEmpty) ...[
            const Text(noPaymentAccountsString),
            _addButton(addPaymentAccountString, controller.goAddPaymentAccount),
          ],
          ...controller.paymentAccounts.map(_paymentAccountTile),
        ],
      ),
    );
  }

  Widget _paymentAccountTile(CustomerPaymentAccountEntity account) {
    final String providerName = account.paymentProvider?.name ?? paymentProviderString;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        account.isDefault ? Icons.star : Icons.account_balance_wallet_outlined,
        color: primaryColor,
      ),
      title: Text('$providerName · ${account.identifier}'),
      subtitle: Text(account.holderName ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => controller.deletePaymentAccount(account),
      ),
    );
  }

  // ---------------- 4. Tipo ----------------

  Widget _typeSection() {
    return _section(
      title: typeString,
      onEdit: controller.goEditManageData,
      children: [
        _infoRow(typeCustomerString, controller.typeCustomerName),
        _infoRow(assignedRecoveryAgentString, controller.recoveryAgentName),
      ],
    );
  }

  // ---------------- Piezas comunes ----------------

  Widget _section({
    required String title,
    required List<Widget> children,
    VoidCallback? onEdit,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  )
                else
                  const SizedBox(height: 48),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  /// Boton que se muestra cuando la seccion esta vacia.
  Widget _addButton(String text, VoidCallback onTap) {
    return ButtonWidget(
      padding: const EdgeInsets.only(top: 12, right: 8),
      text: text,
      buttonType: ButtonTypeWidget.ghost,
      fontSize: 16,
      onTap: onTap,
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
