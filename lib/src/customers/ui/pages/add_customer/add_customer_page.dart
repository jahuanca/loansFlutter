import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:utils/utils.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

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
          padding: const EdgeInsets.all(8),
          text: 'Confirmar',
          onTap: controller.goConfirm,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<AddCustomerController>(
                id: typesDocumentIdGet,
                builder: (controller) => DropdownMenuWidget(
                  isAlignLabel: true,
                  label: 'Tipo de documento',
                  hintText: 'Seleccione el tipo de documento',
                  items: controller.typesDocument,
                  idLabel: 'name',
                  idValue: 'id',
                  value: controller.typeDocumentSelected?.id,
                  onChanged: controller.onChangedTypeDocument,
                ),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.createCustomerRequest.document,
                    isAlignLabel: true,
                    onChanged: controller.onChangedDocument,
                    label: 'Documento',
                    textInputType: TextInputType.number,
                    hintText: 'Ingrese el documento',
                    maxLength: CustomerEntity.maxLenghtOfDocument,
                ),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.createCustomerRequest.alias,
                    textInputType: TextInputType.name,
                    onChanged: controller.onChangedAlias,
                    isAlignLabel: true,
                    label: 'Alias',
                    hintText: 'Ingrese un alias para el cliente',
                    maxLength: CustomerEntity.maxLenghtOfAlias,
                ),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.createCustomerRequest.name,
                    textInputType: TextInputType.name,
                    onChanged: controller.onChangedName,
                    isAlignLabel: true,
                    label: 'Nombre',
                    hintText: 'Ingrese el nombre del cliente'),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.createCustomerRequest.lastName,
                    textInputType: TextInputType.name,
                    onChanged: controller.onChangedLastname,
                    isAlignLabel: true,
                    label: 'Apellido',
                    hintText: 'Ingrese el apellido del cliente'),
              ),
              GetBuilder<AddCustomerController>(
                builder: (controller) => InputWidget(
                    initialValue: controller.createCustomerRequest.address,
                    textInputType: TextInputType.streetAddress,
                    onChanged: controller.onChangedAddress,
                    isAlignLabel: true,
                    label: 'Dirección',
                    hintText: 'Ingrese la dirección del cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
