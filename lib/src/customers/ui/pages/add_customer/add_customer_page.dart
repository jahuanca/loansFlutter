import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
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
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    focusNode: focusNodeAddress,
                    initialValue: controller.ui.address?.value,
                    textInputType: TextInputType.streetAddress,
                    onChanged: controller.onChangedAddress,
                    maxLength: 50,
                    isAlignLabel: true,
                    label: addressString,
                    hintText: 'Ingrese la dirección del cliente'),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.ui.phone?.value,
                    textInputType: TextInputType.phone,
                    onChanged: controller.onChangedPhone,
                    maxLength: 9,
                    isAlignLabel: true,
                    label: phoneString,
                    hintText: 'Ingrese el número de celular'),
              ),
              GetBuilder<AddCustomerController>(
                id: typesCustomerIdGet,
                builder: (controller) => DropdownWidget(
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
        ),
      ),
    );
  }

  Widget _sectionPersonalData() {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '1) Datos personales: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          GetBuilder<AddCustomerController>(
            id: typesDocumentIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: (Widget child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
              inputBorderCurrent: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(width: 0.25, color: primaryColor)),
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
                focusNode: focusNodeLastName,
                initialValue: controller.ui.lastName?.value,
                textInputType: TextInputType.name,
                onChanged: controller.onChangedLastname,
                isAlignLabel: true,
                label: lastNameString,
                hintText: enterLastNameOfCustomerString),
          ),
        ],
      ),
    );
  }
}
