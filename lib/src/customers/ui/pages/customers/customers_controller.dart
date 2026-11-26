import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/di/customer_analytics_binding.dart';
import 'package:loands_flutter/src/customers/di/customer_detail_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_analytics/customer_analytics_page.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_detail/customer_detail_page.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class CustomersController extends GetxController {
  GetCustomersUseCase getCustomersUseCase;
  List<CustomerEntity> customers = [];
  List<CustomerEntity> customersToShow = [];
  bool isSearching = false;

  CustomersController({
    required this.getCustomersUseCase,
  });

  @override
  void onReady() async {
    await getCustomers();
    super.onReady();
  }

  Future<void> getCustomers() async {
    customersToShow.clear();
    showLoading();
    Result<List<CustomerEntity>> resultType =
        await getCustomersUseCase.execute();
    switch (resultType) {
      case Success():
      customers = resultType.value;
      customersToShow.addAll(customers);
        break;
      case Error(): 
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: 'Ocurrio un error');
        break;
    }
    hideLoading();
    update([pageIdGet]);
  }

  /// Al crear, el formulario se reemplaza por el detalle del cliente y este await
  /// termina: se recarga la lista para que aparezca el cliente nuevo.
  Future<void> goToAddCustomer() async {
    await Get.to(() => AddCustomerPage(), binding: AddCustomerBinding());
    getCustomers();
  }

  void goToCustomerAnalytic() {
    Get.to(() => CustomerAnalyticsPage(),
        binding: CustomerAnalyticsBinding(),
        arguments: {customersArgument: customers});
  }

  void goToDeleteCustomer() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Está seguro de eliminar el cliente?');
    if (result) {}
  }

  /// Abre el detalle; si alli se edito el cliente, vuelve actualizado y se reemplaza en la lista.
  void goToDetail(CustomerEntity customer) async {
    final result = await Get.to<CustomerEntity>(
      () => CustomerDetailPage(),
      binding: CustomerDetailBinding(),
      arguments: {customerArgument: customer},
    );
    if (result == null) return;

    final int index = customers.indexWhere((e) => e.id == result.id);
    if (index != notFoundPosition) customers[index] = result;
    final int indexToShow = customersToShow.indexWhere((e) => e.id == result.id);
    if (indexToShow != notFoundPosition) customersToShow[indexToShow] = result;
    update([pageIdGet]);
  }

  void onChangedSearch(String value) {
    if (value == emptyString) {
      clearSearch();
      return;
    }
    isSearching = true;
    customersToShow.clear();
    customersToShow.addAll(customers.where(
        (e) => e.aliasOrFullName.toLowerCase().contains(value.toLowerCase())));
    update([pageIdGet]);
  }

  void clearSearch() {
    isSearching = false;
    customersToShow.clear();
    customersToShow.addAll(customers);
    update([pageIdGet]);
  }
}
