
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customers_binding.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_page.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_page.dart';
import 'package:loands_flutter/src/loans/di/loans_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';

class DashboardController extends GetxController {
  Types selected = Types.week;


  void goToLoans(){
    Get.to(()=> LoansPage(), binding: LoansBinding());
  }

  void goToCustomers(){
    Get.to(()=> const CustomersPage(), binding: CustomersBinding());
  }
}