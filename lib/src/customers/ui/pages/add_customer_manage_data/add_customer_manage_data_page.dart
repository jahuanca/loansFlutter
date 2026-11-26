import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_controller.dart';
import 'package:loands_flutter/src/customers/ui/widgets/customer_form_section_widget.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Seccion del formulario de cliente. Se usa en AddCustomerPage (junto a la otra
/// seccion, sin scroll propio) y sola en EditCustomerPage.
class AddCustomerManageDataPage extends StatelessWidget {
  AddCustomerManageDataPage({super.key, this.isScrollable = true});

  final bool isScrollable;

  final AddCustomerManageDataController controller =
      Get.find<AddCustomerManageDataController>();

  @override
  Widget build(BuildContext context) {
    return CustomerFormSectionWidget(
      title: manageCustomerString,
      isScrollable: isScrollable,
      children: [
        GetBuilder<AddCustomerManageDataController>(
          id: typesCustomerIdGet,
          builder: (controller) => DropdownWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
            isAlignLabel: true,
            label: typeCustomerString,
            hintText: 'Seleccione el tipo de cliente',
            items: controller.typesCustomer,
            value: controller.ui.idTypeCustomer?.value,
            onChanged: controller.onChangedTypeCustomer,
          ),
        ),
        GetBuilder<AddCustomerManageDataController>(
          id: assignedRecoveryIdGet,
          builder: (controller) => DropdownWidget(
            wrapperWidget: customerNoWrapper,
            inputBorderCurrent: customerInputBorder,
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
    );
  }
}
