import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_step_enum.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_data/add_customer_payment_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/widgets/customer_form_section_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Paso 3 del formulario de cliente (antes _sectionPaymentData).
class AddCustomerPaymentDataPage extends StatelessWidget {
  AddCustomerPaymentDataPage({super.key});

  final AddCustomerPaymentDataController controller =
      Get.find<AddCustomerPaymentDataController>();

  @override
  Widget build(BuildContext context) {
    return CustomerFormSectionWidget(
      title: AddCustomerStep.paymentData.title,
      children: [
        GetBuilder<AddCustomerPaymentDataController>(
          id: paymentAccountsIdGet,
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.ui.paymentAccounts.isEmpty)
                const Padding(
                  padding: defaultPadding,
                  child: Text(noPaymentAccountsString),
                ),
              ...List.generate(
                controller.ui.paymentAccounts.length,
                (index) => _paymentAccountTile(controller, index),
              ),
              ButtonWidget(
                padding: defaultPadding,
                text: addPaymentAccountString,
                buttonType: ButtonTypeWidget.ghost,
                fontSize: 16,
                onTap: controller.goAddPaymentAccount,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentAccountTile(AddCustomerPaymentDataController controller, int index) {
    final CustomerPaymentAccountEntity account = controller.ui.paymentAccounts[index];
    final String providerName = account.paymentProvider?.name ?? paymentProviderString;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(account.isDefault ? Icons.star : Icons.account_balance_wallet_outlined,
          color: primaryColor),
      title: Text('$providerName · ${account.identifier}'),
      subtitle: Text(account.holderName ?? ''),
      onTap: () => controller.goEditPaymentAccount(index),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => controller.removePaymentAccount(index),
      ),
    );
  }
}
