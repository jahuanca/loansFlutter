import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_controller.dart';
import 'package:loands_flutter/src/utils/ui/paddings.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class CustomersPage extends StatelessWidget {
  final CustomersController controller =
      CustomersController(getCustomersUseCase: Get.find());
  final FocusNode focusNodeOfSearch = FocusNode();

  final TextEditingController searchController = TextEditingController();

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
                appBar: _appBar(),
                floatingActionButton: _floatingButtons(),
                body: _body(size),
              ),
            ));
  }

  AppBar _appBar() => appBarWidget(
        text: customersString,
        hasArrowBack: true,
      );

  Widget _floatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: addHeroTag,
          onPressed: controller.goToAddCustomer,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: analyticsHeroTag,
          onPressed: controller.goToCustomerAnalytic,
          backgroundColor: infoColor(),
          child: const Icon(
            Icons.analytics,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _body(Size size) {
    return Column(
      children: [
        SearchInputWidget(
          padding: Paddings.search,
          focusNode: focusNodeOfSearch,
          hintText: '¿Qué cliente desea buscar?',
          controller: searchController,
          onChanged: controller.onChangedSearch,
          isSearching: controller.isSearching,
          onClear: _clearSearch,
          textOfResults: _textOfResults,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.customersToShow.length,
            itemBuilder: (context, index) => _item(
              size: size,
              index: index,
              customer: controller.customersToShow[index],
            ),
          ),
        ),
      ],
    );
  }

  void _clearSearch() {
    searchController.clear();
    controller.clearSearch();
  }

  String get _textOfResults {
    int results = controller.customers.length;
    int resultsOfShow = controller.customersToShow.length;
    return (controller.isSearching.not())
        ? 'Total: $results'
        : 'Total: $results, $resultsOfShow coincidencias.';
  }

  Widget _item({
    required int index,
    required CustomerEntity customer,
    required Size size,
  }) {
    return ItemListImageDataWidget(
      onTap: () => controller.goToDetail(customer),
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
    );
  }
}