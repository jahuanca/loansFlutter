import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

  final FocusNode focusNodeDocument = FocusNode();
  final FocusNode focusNodeAlias = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeLastName = FocusNode();
  final FocusNode focusNodeAddress = FocusNode();
  final FocusNode focusNodeAccountNumber = FocusNode();
  final FocusNode focusNodeCci = FocusNode();
  final FocusNode focusNodePaymentPhone = FocusNode();
  final FocusNode focusNodeHolderName = FocusNode();

  final AddCustomerController controller = AddCustomerController(
    getUsersUseCase: Get.find(),
    getTypesDocumentUseCase: Get.find(),
    createCustomerUseCase: Get.find(),
    updateCustomerUseCase: Get.find(),
    getTypesCustomerUseCase: Get.find(),
  );

  @override
  Widget build(BuildContext context) {
    String titleAppbar =
        controller.isEditing ? editCustomerString : addCustomerString;

    return GetBuilder<AddCustomerController>(
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
          child: Column(
            children: [
              _sectionPersonalData(),
              _sectionAddressData(),
              _sectionPaymentData(),
              _sectionManageData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subtitleForm(String title) {
    return Padding(
      padding: defaultPadding,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _sectionPersonalData() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitleForm('Información personal'),
          GetBuilder<AddCustomerController>(
            id: typesDocumentIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              isAlignLabel: true,
              label: typeDocumentString,
              hintText: 'Seleccione el tipo de documento',
              items: controller.typesDocument,
              value: controller.ui.idTypeDocument?.value,
              onChanged: controller.onChangedTypeDocument,
            ),
          ),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              initialValue: controller.ui.document?.value,
              isAlignLabel: true,
              onChanged: controller.onChangedDocument,
              label: documentString,
              textInputType: TextInputType.number,
              hintText: enterDocumentString,
              maxLength: CustomerEntity.maxLenghtOfDocument,
              focusNode: focusNodeDocument,
            ),
          ),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              initialValue: controller.ui.alias?.value,
              textInputType: TextInputType.name,
              onChanged: controller.onChangedAlias,
              isAlignLabel: true,
              label: aliasString,
              hintText: 'Ingrese un alias para el cliente',
              maxLength: CustomerEntity.maxLenghtOfAlias,
              focusNode: focusNodeAlias,
            ),
          ),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
                wrapperWidget: _noWrapper,
                inputBorderCurrent: currentBorder,
                focusNode: focusNodeName,
                initialValue: controller.ui.name?.value,
                textInputType: TextInputType.name,
                onChanged: controller.onChangedName,
                isAlignLabel: true,
                label: nameString,
                hintText: enterCustomerNameString),
          ),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
                wrapperWidget: _noWrapper,
                inputBorderCurrent: currentBorder,
                focusNode: focusNodeLastName,
                initialValue: controller.ui.lastName?.value,
                textInputType: TextInputType.name,
                onChanged: controller.onChangedLastname,
                isAlignLabel: true,
                label: lastNameString,
                hintText: enterLastNameOfCustomerString),
          ),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
                wrapperWidget: _noWrapper,
                inputBorderCurrent: currentBorder,
                initialValue: controller.ui.phone?.value,
                textInputType: TextInputType.phone,
                onChanged: controller.onChangedPhone,
                maxLength: 9,
                isAlignLabel: true,
                label: phoneString,
                hintText: 'Ingrese el número de celular'),
          ),
        ],
      ),
    );
  }

  Widget _sectionAddressData() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitleForm('Domicilio'),
          GetBuilder<AddCustomerController>(
            builder: (controller) => InputWidget(
                wrapperWidget: _noWrapper,
                inputBorderCurrent: currentBorder,
                focusNode: focusNodeAddress,
                initialValue: controller.ui.address?.value,
                textInputType: TextInputType.streetAddress,
                onChanged: controller.onChangedAddress,
                maxLength: 50,
                isAlignLabel: true,
                label: addressString,
                hintText: 'Ingrese la dirección del cliente'),
          ),
          InputWidget(
            label: 'Referencia',
            wrapperWidget: _noWrapper,
            inputBorderCurrent: currentBorder,
            hintText: 'Referencia',
            isTextArea: true,
          ),
          const LabelWidget(padding: defaultPadding, label: 'Foto de la casa'),
          Center(child: ImageActionWidget(height: 200, width: 200)),
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  label: 'Latitud',
                  wrapperWidget: _noWrapper,
                  inputBorderCurrent: currentBorder,
                  hintText: 'Latitud',
                  enabled: false,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputWidget(
                  label: 'Longitud',
                  wrapperWidget: _noWrapper,
                  inputBorderCurrent: currentBorder,
                  hintText: 'Longitud',
                  enabled: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: ButtonWidget(
                text: 'Capturar',
                buttonType: ButtonTypeWidget.ghost,
                buttonStyle: ButtonStyleWidget.success,
                fontSize: 16,
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: ButtonWidget(
                text: 'Ver en mapa',
                buttonType: ButtonTypeWidget.link,
                buttonStyle: ButtonStyleWidget.info,
                fontSize: 16,
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _sectionPaymentData() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitleForm(paymentDataString),
          GetBuilder<AddCustomerController>(
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
          GetBuilder<AddCustomerController>(
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
          GetBuilder<AddCustomerController>(
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
          GetBuilder<AddCustomerController>(
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
          GetBuilder<AddCustomerController>(
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
        ],
      ),
    );
  }

  Widget _sectionManageData() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitleForm('Manejo de cliente'),
          GetBuilder<AddCustomerController>(
            id: typesCustomerIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              isAlignLabel: true,
              label: typeCustomerString,
              hintText: 'Seleccione el tipo de cliente',
              items: controller.typesCustomer,
              value: controller.ui.idTypeCustomer?.value,
              onChanged: controller.onChangedTypeCustomer,
            ),
          ),
          GetBuilder<AddCustomerController>(
            id: assignedRecoveryIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: _noWrapper,
              inputBorderCurrent: currentBorder,
              idLabel: 'fullName',
              isAlignLabel: true,
              label: assignedRecoveryAgentString,
              hintText: 'Seleccione al recuperador',
              items: controller.users,
              value: controller.ui.idAssignedRecoveryAgent?.value,
              onChanged: controller.onChangedAssignedRecovery,
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
