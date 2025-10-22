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
    getTypesDocumentUseCase: Get.find(),
    createCustomerUseCase: Get.find(),
    updateCustomerUseCase: Get.find(),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCustomerController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(
          text: controller.isEditing ? 'Editar cliente' : 'Agregar cliente',
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
              GetBuilder<AddCustomerController>(
                id: typesDocumentIdGet,
                builder: (controller) => DropdownWidget(
                  isAlignLabel: true,
                  label: typeDocumentString,
                  hintText: 'Seleccione el tipo de documento',
                  items: controller.typesDocument,
                  value: controller.typeDocumentSelected?.id,
                  onChanged: controller.onChangedTypeDocument,
                ),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                  initialValue: controller.createCustomerRequest.document,
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
                  initialValue: controller.createCustomerRequest.alias,
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
                    initialValue: controller.createCustomerRequest.name,
                    textInputType: TextInputType.name,
                    onChanged: controller.onChangedName,
                    isAlignLabel: true,
                    label: nameString,
                    hintText: enterCustomerNameString),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    focusNode: focusNodeLastName,
                    initialValue: controller.createCustomerRequest.lastName,
                    textInputType: TextInputType.name,
                    onChanged: controller.onChangedLastname,
                    isAlignLabel: true,
                    label: lastNameString,
                    hintText: enterLastNameOfCustomerString),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    focusNode: focusNodeAddress,
                    initialValue: controller.createCustomerRequest.address,
                    textInputType: TextInputType.streetAddress,
                    onChanged: controller.onChangedAddress,
                    maxLength: 50,
                    isAlignLabel: true,
                    label: addressString,
                    hintText: 'Ingrese la dirección del cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
