import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/di/get_customer_analytics_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
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
    ResultType<List<CustomerEntity>, ErrorEntity> resultType =
        await getCustomersUseCase.execute();
    if (resultType is Success) {
      customers = resultType.data as List<CustomerEntity>;
      customersToShow.addAll(customers);
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: 'Ocurrio un error');
    }
    hideLoading();
    update([pageIdGet]);
  }

  void goToAddCustomer() {
    Get.to(() => AddCustomerPage(), binding: AddCustomerBinding());
  }

  void goToCustomerAnalytic() {
    Get.to(() => CustomerAnalyticsPage(),
        binding: GetCustomerAnalyticsBinding(),
        arguments: {customersArgument: customers});
  }

  void goToEditCustomer(CustomerEntity customer) {
    Get.to(() => AddCustomerPage(),
        binding: AddCustomerBinding(), arguments: {customerArgument: customer});
  }

  void goToDeleteCustomer() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Está seguro de eliminar el cliente?');
    if (result) {}
  }

  void goToDetail(CustomerEntity customer) {
    Get.to(() => const CustomerDetailPage(), arguments: {
      customerArgument: customer,
    });
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
