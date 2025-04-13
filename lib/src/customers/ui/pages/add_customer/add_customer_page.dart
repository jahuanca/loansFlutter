import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:utils/utils.dart';

class AddCustomerPage extends StatelessWidget {
  
  AddCustomerPage({super.key});

  final AddCustomerController controller = Get.find<AddCustomerController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCustomerController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(
          text: 'Agregar cliente',
          hasArrowBack: true,
        ),
        bottomNavigationBar: ButtonWidget(
          padding: const EdgeInsets.all(8),
          text: 'Agregar',
          onTap: controller.create,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<AddCustomerController>(
                    id: 'typesDocument',
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
                        isAlignLabel: true,
                        onChanged: controller.onChangedDocument,
                        label: 'Documento',
                        textInputType: TextInputType.number,
                        hintText: 'Ingrese el documento'),
                  ),
                  GetBuilder<AddCustomerController>(
                    builder: (controller) => InputWidget(
                        textInputType: TextInputType.name,
                        onChanged: controller.onChangedName,
                        isAlignLabel: true,
                        label: 'Nombre',
                        hintText: 'Ingrese el nombre del cliente'),
                  ),
                  GetBuilder<AddCustomerController>(
                    builder: (controller) => InputWidget(
                        textInputType: TextInputType.name,
                        onChanged: controller.onChangedLastname,
                        isAlignLabel: true,
                        label: 'Apellido',
                        hintText: 'Ingrese el apellido del cliente'),
                  ),
                  GetBuilder<AddCustomerController>(
                    builder: (controller) => InputWidget(
                        textInputType: TextInputType.streetAddress,
                        onChanged: controller.onChangedAddress,
                        isAlignLabel: true,
                        label: 'Dirección',
                        hintText: 'Ingrese la dirección del cliente'),
                  ),
                ],
              ),
            ),
            GetBuilder<AddCustomerController>(
              id: validandoIdGet,
              builder: (controller) => LoadingWidget(show: controller.isLoading),
            )
          ],
        ),
      ),
    );
  }
}
