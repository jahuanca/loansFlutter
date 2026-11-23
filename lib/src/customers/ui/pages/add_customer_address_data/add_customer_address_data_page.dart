import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_step_enum.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_address_data/add_customer_address_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/widgets/customer_form_section_widget.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Paso 2 del formulario de cliente (antes _sectionAddressData).
class AddCustomerAddressDataPage extends StatelessWidget {
  AddCustomerAddressDataPage({super.key});

  final FocusNode focusNodeAddress = FocusNode();

  final AddCustomerAddressDataController controller =
      Get.find<AddCustomerAddressDataController>();

  @override
  Widget build(BuildContext context) {
    return CustomerFormSectionWidget(
      title: AddCustomerStep.addressData.title,
      children: [
        GetBuilder<AddCustomerAddressDataController>(
          builder: (controller) => InputWidget(
              wrapperWidget: customerNoWrapper,
              inputBorderCurrent: customerInputBorder,
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
          wrapperWidget: customerNoWrapper,
          inputBorderCurrent: customerInputBorder,
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
                wrapperWidget: customerNoWrapper,
                inputBorderCurrent: customerInputBorder,
                hintText: 'Latitud',
                enabled: false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: InputWidget(
                label: 'Longitud',
                wrapperWidget: customerNoWrapper,
                inputBorderCurrent: customerInputBorder,
                hintText: 'Longitud',
                enabled: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: ButtonWidget(
              text: 'Capturar',
              buttonType: ButtonTypeWidget.ghost,
              buttonStyle: ButtonStyleWidget.success,
              fontSize: 16,
            )),
            const SizedBox(width: 16),
            Expanded(
                child: ButtonWidget(
              text: 'Ver en mapa',
              buttonType: ButtonTypeWidget.link,
              buttonStyle: ButtonStyleWidget.info,
              fontSize: 16,
            )),
          ],
        ),
      ],
    );
  }
}
