import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_manage_data/add_customer_manage_data_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_personal_data/add_customer_personal_data_page.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Alta de cliente en un solo formulario con dos secciones (informacion personal y
/// manejo de cliente). Direcciones y cuentas de pago se agregan luego desde el detalle,
/// al que se llega automaticamente al crear.
class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

  final AddCustomerController controller = Get.find<AddCustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        text: addCustomerString,
        hasArrowBack: true,
      ),
      bottomNavigationBar: Padding(
        padding: defaultPadding,
        child: ButtonWidget(
          text: createString,
          onTap: controller.goCreate,
        ),
      ),
      // Un solo scroll para las dos secciones: por eso van con isScrollable: false.
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddCustomerPersonalDataPage(isScrollable: false),
            AddCustomerManageDataPage(isScrollable: false),
          ],
        ),
      ),
    );
  }
}
