import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customer_analytics_use_case.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/di/loans_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class CustomerAnalyticsController extends GetxController {
  List<CustomerEntity> customers = [];
  CustomerEntity? customerSelected;
  GetCustomerAnalyticsUseCase getCustomerAnalyticsUseCase;
  CustomerAnalyticsResponse? response;

  CustomerAnalyticsController({
    required this.getCustomerAnalyticsUseCase,
  });

  @override
  void onInit() {
    customers = Get.setArgument(customersArgument);
    super.onInit();
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
    Get.to(()=> LoansPage(), binding: LoansBinding(), arguments: {
      getLoansRequestArgument: GetLoansRequest(
        idCustomer: response?.idCustomer,
      ),
      titleOfAppBarArgument: customerSelected?.aliasOrFullName,
    });
  }
}
