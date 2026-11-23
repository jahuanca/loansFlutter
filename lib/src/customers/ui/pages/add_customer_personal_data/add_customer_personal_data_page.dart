import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_step_enum.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/widgets/customer_form_section_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Paso 1 del formulario de cliente (antes _sectionPersonalData).
class AddCustomerPersonalDataPage extends StatelessWidget {
  AddCustomerPersonalDataPage({super.key});

  final FocusNode focusNodeDocument = FocusNode();
  final FocusNode focusNodeAlias = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeLastName = FocusNode();

  final AddCustomerPersonalDataController controller =
      Get.find<AddCustomerPersonalDataController>();

  @override
  Widget build(BuildContext context) {
    return CustomerFormSectionWidget(
      title: AddCustomerStep.personalData.title,
      children: [
        GetBuilder<AddCustomerPersonalDataController>(
          id: typesDocumentIdGet,
          builder: (controller) => DropdownWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
            isAlignLabel: true,
            label: typeDocumentString,
            hintText: 'Seleccione el tipo de documento',
            items: controller.typesDocument,
            value: controller.ui.idTypeDocument?.value,
            onChanged: controller.onChangedTypeDocument,
          ),
        ),
        GetBuilder<AddCustomerPersonalDataController>(
          builder: (controller) => InputWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
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
        GetBuilder<AddCustomerPersonalDataController>(
          builder: (controller) => InputWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
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
        GetBuilder<AddCustomerPersonalDataController>(
          builder: (controller) => InputWidget(
              wrapperWidget: customerNoWrapper,
              inputBorderCurrent: customerInputBorder,
              focusNode: focusNodeName,
              initialValue: controller.ui.name?.value,
              textInputType: TextInputType.name,
              onChanged: controller.onChangedName,
              isAlignLabel: true,
              label: nameString,
              hintText: enterCustomerNameString),
        ),
        GetBuilder<AddCustomerPersonalDataController>(
          builder: (controller) => InputWidget(
              wrapperWidget: customerNoWrapper,
              inputBorderCurrent: customerInputBorder,
              focusNode: focusNodeLastName,
              initialValue: controller.ui.lastName?.value,
              textInputType: TextInputType.name,
              onChanged: controller.onChangedLastname,
              isAlignLabel: true,
              label: lastNameString,
              hintText: enterLastNameOfCustomerString),
        ),
        GetBuilder<AddCustomerPersonalDataController>(
          builder: (controller) => InputWidget(
              wrapperWidget: customerNoWrapper,
              inputBorderCurrent: customerInputBorder,
              initialValue: controller.ui.phone?.value,
              textInputType: TextInputType.phone,
              onChanged: controller.onChangedPhone,
              maxLength: 9,
              isAlignLabel: true,
              label: phoneString,
              hintText: 'Ingrese el número de celular'),
        ),
      ],
    );
  }
}
