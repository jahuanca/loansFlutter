
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_customer_without_loan_use_case.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class CustomersWithoutLoanController extends GetxController {

  GetCustomerWithoutLoanUseCase getCustomerWithoutLoanUseCase;
  List<CustomerEntity> customers = [];

  CustomersWithoutLoanController({
    required this.getCustomerWithoutLoanUseCase,
  });


  @override
  void onReady() {
    getCustomers();
    super.onReady();
  }

  Future<void> getCustomers() async {
    showLoading();
    Result<List<CustomerEntity>, ErrorEntity> result = 
    await getCustomerWithoutLoanUseCase.execute();
    hideLoading();

    switch (result) {
      case Success():
        customers = result.value;
        update([pageIdGet]);
        break;
      case Error():
        break;
    }
  }
}