import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customer_analytics_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/di/loans_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';
import 'package:loands_flutter/src/utils/ui/widgets/error/error_service.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class CustomerAnalyticsController extends GetxController {
  List<CustomerEntity> customers = [];
  CustomerEntity? customerSelected;
  CustomerAnalyticsResponse? response;

  GetCustomerAnalyticsUseCase getCustomerAnalyticsUseCase;
  GetCustomersUseCase getCustomersUseCase;

  CustomerAnalyticsController({
    required this.getCustomerAnalyticsUseCase,
    required this.getCustomersUseCase,
  });

  @override
  void onReady() async {
    handleArguments();
    super.onReady();
  }

  void handleArguments() async {
    List<CustomerEntity>? customersOfArgument  = Get.setArgument(customersArgument);
    if (customersOfArgument == null) {
      await getCustomers();
    }
    CustomerEntity? customerOfArgument = Get.setArgument(customerArgument);
    if (customerOfArgument != null) {
      onChangedCustomer(customerOfArgument.id);
    }
  }

  Future<void> getCustomers() async {
    showLoading();
    ResultType<List<CustomerEntity>, ErrorEntity> resultType = 
    await getCustomersUseCase.execute();
    hideLoading();
    if (resultType is Success) {
      customers = resultType.data;
      update([pageIdGet]);
    } else {
      showError(context: Get.context!, errorEntity: resultType.error);
    }
  }

  void onChangedCustomer(dynamic idOfCustomer) {
    if (idOfCustomer != null) {
      customerSelected = customers.firstWhere((e) => e.id == idOfCustomer);
      getAnalytics(idOfCustomer);
    }
  }

  void getAnalytics(int idOfCustomer) async {
    showLoading();
    ResultType<CustomerAnalyticsResponse, ErrorEntity> resultType =
        await getCustomerAnalyticsUseCase.execute(idOfCustomer);
    hideLoading();
    if (resultType is Success) {
      response = resultType.data;
      update([pageIdGet]);
    }
  }

  void goAllLoans(){
    Get.to(()=> LoansPage(tag: 'loans_${customerSelected?.id}'), binding: LoansBinding(), arguments: {
      getLoansRequestArgument: GetLoansRequest(
        idCustomer: customerSelected?.id,
      ),
      titleOfAppBarArgument: customerSelected?.aliasOrFullName,
    });
  }
}
