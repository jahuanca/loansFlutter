
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_page.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class CustomersController extends GetxController {

  GetCustomersUseCase getCustomersUseCase;
  List<CustomerEntity> customers = [];

  CustomersController({
    required this.getCustomersUseCase,
  });

  @override
  void onReady() async {
    await getCustomers();
    super.onReady();
  }

  Future<void> getCustomers() async {
    showLoading();
    ResultType<List<CustomerEntity>, ErrorEntity> resultType = await getCustomersUseCase.execute();
    if(resultType is Success){
      customers = resultType.data as List<CustomerEntity>;
    }else{
      showSnackbarWidget(
        context: Get.overlayContext!, 
        typeSnackbar: TypeSnackbar.error, 
        message: 'Ocurrio un error');
    }
    hideLoading();
    update([pageIdGet]);
  }

  void goToAddCustomer(){
    Get.to(()=> AddCustomerPage(), binding: AddCustomerBinding());
  }

  void goToEditCustomer(CustomerEntity customer){
    Get.to(
      ()=> AddCustomerPage(), 
      binding: AddCustomerBinding(),
      arguments: {
        customerArgument: customer
      }
    );
  }

  void goToDeleteCustomer() async {
    bool result = await showDialogWidget(
      context: Get.context!, 
      message: '¿Está seguro de eliminar el cliente?'
    );
    if(result) {

    }
  }
}