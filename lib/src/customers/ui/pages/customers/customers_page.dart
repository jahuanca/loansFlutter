
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_controller.dart';
import 'package:utils/utils.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        GetBuilder<CustomersController>(
          init: Get.find<CustomersController>(),
          id: pageIdGet,
          builder: (controller)=> Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: controller.goToAddCustomer,
              child: const Icon(Icons.add),
            ),
            appBar: appBarWidget(
              text: 'Clientes',
              hasArrowBack: true,
            ),
            body: ListView.builder(
              itemCount: controller.customers.length,
              itemBuilder: (context, index) => _item(
                size: size,
                index: index, customer: controller.customers[index],
              ),),
          ),
        ),
        GetBuilder<CustomersController>(
          id: validandoIdGet,
          builder: (controller) => LoadingWidget(show: controller.validando),)
      ],
    );
  }

  Widget _item({
    required int index, 
    required CustomerEntity customer,
    required Size size,
  }){
    return ItemListImageDataWidget(
      width: size.width, 
      height: size.height * 0.2, 
      path: '', 
      title: customer.fullName,
      subtitle: customer.address,
    );
  }
}