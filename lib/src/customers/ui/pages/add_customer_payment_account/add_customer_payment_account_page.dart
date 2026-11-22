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
      AddCustomerPaymentAccountController();

  @override
  Widget build(BuildContext context) {
    String titleAppbar =
        controller.isEditing ? editPaymentAccountString : addPaymentAccountString;

    return GetBuilder<AddCustomerPaymentAccountController>(
      init: controller,
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
              value: controller.ui.idPaymentProvider?.value,
              onChanged: controller.onChangedPaymentProvider,
            ),
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => InputWidget(
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
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => InputWidget(
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
          ),
          GetBuilder<AddCustomerPaymentAccountController>(
            builder: (controller) => InputWidget(
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

  Widget _noWrapper(Widget child) {
    return child;
  }

  final InputBorder currentBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(width: 0.25, color: primaryColor));
}
