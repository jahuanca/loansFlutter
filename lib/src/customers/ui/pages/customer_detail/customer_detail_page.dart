import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_detail/customer_detail_controller.dart';
import 'package:utils/utils.dart';

class CustomerDetailPage extends StatelessWidget {
  const CustomerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<CustomerDetailController>(
      init: CustomerDetailController(),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: controller.customer.aliasOrFullName),
        body: ListView(
          children: [
            _header(size),
          ],
        ),
      ),
    );
  }

  Widget _header(Size size) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: const Text('Texto'),
    );
  }
}
