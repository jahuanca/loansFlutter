import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Formulario de cuenta de pago, separado de AddCustomerPage (antes _sectionPaymentData).
class AddCustomerPaymentAccountPage extends StatelessWidget {
  AddCustomerPaymentAccountPage({super.key});

  final FocusNode focusNodeAccountNumber = FocusNode();
  final FocusNode focusNodeCci = FocusNode();
  final FocusNode focusNodePaymentPhone = FocusNode();
  final FocusNode focusNodeHolderName = FocusNode();
  final FocusNode focusNodeObservation = FocusNode();

  final AddCustomerPaymentAccountController controller =
      Get.find<AddCustomerPaymentAccountController>();

  @override
  Widget build(BuildContext context) {
    String titleAppbar =
        controller.isEditing ? editPaymentAccountString : addPaymentAccountString;

    return GetBuilder<AddCustomerPaymentAccountController>(
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(
          text: titleAppbar,
          hasArrowBack: true,
        ),
        bottomNavigationBar: ButtonWidget(
          padding: defaultPadding,
          text: confirmString,
          onTap: controller.goConfirm,
        ),
        body: SingleChildScrollView(
          child: _sectionPaymentData(),
        ),
      ),
    );
  }

  Widget _sectionPaymentData() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<AddCustomerPaymentAccountController>(
            id: paymentProvidersIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              isAlignLabel: true,
              label: paymentProviderString,
              hintText: selectPaymentProviderString,
              items: controller.paymentProviders,
              // Hasta que llega la lista, el valor es null: un DropdownButton
              // falla si su value no esta entre los items.
              value: controller.paymentProviderSelected?.id,
              onChanged: controller.onChangedPaymentProvider,
            ),
          ),
          // Se reconstruye al cambiar de proveedor (mismo id que el dropdown):
          // banco -> numero de cuenta + CCI; billetera -> solo celular.
          GetBuilder<AddCustomerPaymentAccountController>(
            id: paymentProvidersIdGet,
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.showBankFields) ..._bankFields(controller),
                if (controller.showWalletFields) _walletField(controller),
              ],
            ),
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => InputWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              focusNode: focusNodeHolderName,
              initialValue: controller.ui.holderName?.value,
              textInputType: TextInputType.name,
              onChanged: controller.onChangedHolderName,
              maxLength: CustomerPaymentAccountEntity.maxLengthOfHolderName,
              isAlignLabel: true,
              label: holderNameString,
              hintText: enterHolderNameString,
            ),
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => InputWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              focusNode: focusNodeObservation,
              initialValue: controller.ui.observation?.value,
              textInputType: TextInputType.text,
              onChanged: controller.onChangedObservation,
              maxLength: CustomerPaymentAccountEntity.maxLengthOfObservation,
              isAlignLabel: true,
              isTextArea: true,
              label: observationString,
              hintText: enterObservationString,
            ),
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(isDefaultAccountString),
              value: controller.ui.isDefault,
              onChanged: controller.onChangedIsDefault,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _bankFields(AddCustomerPaymentAccountController controller) {
    return [
      InputWidget(
        wrapperWidget: _noWrapper,
        inputBorderCurrent: currentBorder,
        focusNode: focusNodeAccountNumber,
        initialValue: controller.ui.accountNumber?.value,
        textInputType: TextInputType.number,
        onChanged: controller.onChangedAccountNumber,
        maxLength: CustomerPaymentAccountEntity.maxLengthOfAccountNumber,
        isAlignLabel: true,
        label: accountNumberString,
        hintText: enterAccountNumberString,
      ),
      InputWidget(
        wrapperWidget: _noWrapper,
        inputBorderCurrent: currentBorder,
        focusNode: focusNodeCci,
        initialValue: controller.ui.cci?.value,
        textInputType: TextInputType.number,
        onChanged: controller.onChangedCci,
        maxLength: CustomerPaymentAccountEntity.maxLengthOfCci,
        isAlignLabel: true,
        label: cciString,
        hintText: enterCciString,
      ),
    ];
  }

  Widget _walletField(AddCustomerPaymentAccountController controller) {
    return InputWidget(
      wrapperWidget: _noWrapper,
      inputBorderCurrent: currentBorder,
      focusNode: focusNodePaymentPhone,
      initialValue: controller.ui.paymentPhone?.value,
      textInputType: TextInputType.phone,
      onChanged: controller.onChangedPaymentPhone,
      maxLength: CustomerPaymentAccountEntity.maxLengthOfPhone,
      isAlignLabel: true,
      label: paymentPhoneString,
      hintText: enterPaymentPhoneString,
    );
  }

  Widget _noWrapper(Widget child) {
    return child;
  }

  final InputBorder currentBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(width: 0.25, color: primaryColor));
}
