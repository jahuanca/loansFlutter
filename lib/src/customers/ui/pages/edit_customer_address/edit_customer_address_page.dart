import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer_address/edit_customer_address_controller.dart';
import 'package:loands_flutter/src/customers/ui/widgets/customer_form_section_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Formulario de direccion para crear o editar (ver EditCustomerAddressController).
class EditCustomerAddressPage extends StatelessWidget {
  EditCustomerAddressPage({super.key});

  final EditCustomerAddressController controller =
      Get.find<EditCustomerAddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(text: controller.title, hasArrowBack: true),
      body: CustomerFormSectionWidget(
        title: addressString,
        children: [
          GetBuilder<EditCustomerAddressController>(
            id: addressTypeIdGet,
            builder: (controller) => DropdownWidget(
              wrapperWidget: customerNoWrapper,
              inputBorderCurrent: customerInputBorder,
              isAlignLabel: true,
              label: addressTypeString,
              items: CustomerAddressType.values,
              value: controller.type.value,
              onChanged: controller.onChangedType,
            ),
          ),
          InputWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
            isAlignLabel: true,
            label: addressString,
            hintText: enterAddressString,
            initialValue: controller.address?.value,
            maxLength: CustomerAddressEntity.maxLengthOfAddress,
            onChanged: controller.onChangedAddress,
          ),
          InputWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
            isAlignLabel: true,
            label: referenceString,
            hintText: enterReferenceString,
            initialValue: controller.reference,
            maxLength: CustomerAddressEntity.maxLengthOfReference,
            onChanged: controller.onChangedReference,
          ),
          GetBuilder<EditCustomerAddressController>(
            id: isPrimaryIdGet,
            builder: (controller) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(primaryAddressString),
              subtitle: controller.primaryLockedMessage == null
                  ? null
                  : Text(controller.primaryLockedMessage!),
              value: controller.isPrimary,
              onChanged:
                  controller.canChangePrimary ? controller.onChangedIsPrimary : null,
            ),
          ),
          _location(),
          if (controller.isEditing)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(keepImageString),
            )
          else
            _imagePicker(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: defaultPadding,
        child: ButtonWidget(text: saveString, onTap: controller.save),
      ),
    );
  }

  Widget _location() {
    return GetBuilder<EditCustomerAddressController>(
      id: locationIdGet,
      builder: (controller) {
        final double? accuracy = controller.accuracyInMeters;
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(locationString, style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text(captureAtAddressHintString,
                  style: TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 8),
              if (controller.hasLocation)
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${controller.latitude}, ${controller.longitude}'
                        '${accuracy == null ? '' : '  (± ${accuracy.round()} m)'}',
                      ),
                    ),
                    IconButton(
                      tooltip: viewOnMapString,
                      icon: const Icon(Icons.map_outlined),
                      onPressed: controller.goToMap,
                    ),
                  ],
                )
              else
                const Row(
                  children: [
                    Icon(Icons.location_off_outlined, color: Colors.black45),
                    SizedBox(width: 8),
                    Text(noLocationString),
                  ],
                ),
              ButtonWidget(
                padding: const EdgeInsets.only(top: 8),
                text: controller.hasLocation
                    ? recaptureLocationString
                    : captureLocationString,
                buttonType: ButtonTypeWidget.ghost,
                onTap: controller.captureLocation,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _imagePicker() {
    return GetBuilder<EditCustomerAddressController>(
      id: addressImageIdGet,
      builder: (controller) {
        final file = controller.imageFile;
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(addressPhotoString,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              if (file != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.file(file, height: 180, width: double.infinity, fit: BoxFit.cover),
                ),
              ButtonWidget(
                padding: const EdgeInsets.only(top: 8),
                text: file == null ? pickPhotoString : changePhotoString,
                buttonType: ButtonTypeWidget.ghost,
                onTap: controller.pickImage,
              ),
            ],
          ),
        );
      },
    );
  }
}
