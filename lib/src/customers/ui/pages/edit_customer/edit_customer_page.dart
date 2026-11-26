import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/edit_customer/edit_customer_section_enum.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Reutiliza la pagina de la seccion del alta como cuerpo y agrega el boton Guardar.
class EditCustomerPage extends StatelessWidget {
  EditCustomerPage({super.key});

  final EditCustomerController controller = Get.find<EditCustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(text: controller.section.title, hasArrowBack: true),
      body: switch (controller.section) {
        EditCustomerSection.personalData => AddCustomerPersonalDataPage(),
        EditCustomerSection.manageData => AddCustomerManageDataPage(),
      },
      bottomNavigationBar: Padding(
        padding: defaultPadding,
        child: ButtonWidget(text: saveString, onTap: controller.save),
      ),
    );
  }
}
