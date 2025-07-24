import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_controller.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class CustomersPage extends StatelessWidget {
  final CustomersController controller =
      CustomersController(getCustomersUseCase: Get.find());

  CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<CustomersController>(
        init: controller,
        id: pageIdGet,
        builder: (controller) => RefreshIndicator(
              onRefresh: controller.getCustomers,
              child: Scaffold(
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: addHeroTag,
                      onPressed: controller.goToAddCustomer,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 8,),
                    FloatingActionButton(
                      heroTag: analyticsHeroTag,
                      onPressed: controller.goToCustomerAnalytic,
                      backgroundColor: infoColor(),
                      child: const Icon(Icons.analytics, color: Colors.white,),
                    ),
                  ],
                ),
                appBar: appBarWidget(
                  text: customersString,
                  hasArrowBack: true,
                ),
                body: ListView.builder(
                  itemCount: controller.customers.length,
                  itemBuilder: (context, index) => _item(
                    size: size,
                    index: index,
                    customer: controller.customers[index],
                  ),
                ),
              ),
            ));
  }

  Widget _item({
    required int index,
    required CustomerEntity customer,
    required Size size,
  }) {
    return ItemListImageDataWidget(
      paddingAll: defaultPadding,
      decorationAll: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(borderRadius()),
      ),
      width: size.width,
      height: size.height * 0.16,
      path: 'packages/utils/assets/images/image_not_found.png',
      storageType: StorageType.localStorage,
      title: customer.fullName,
      subtitle: customer.address,
      detail: customer.alias,
      alignmentOfActions: MainAxisAlignment.spaceEvenly,
      actions: [
        IconButtonWidget(
          onPressed: () => controller.goToEditCustomer(customer),
          iconData: Icons.edit,
          shape: BoxShape.circle,
          backgroundColor: infoColor(),
        ),
      ],
    );
  }
}
