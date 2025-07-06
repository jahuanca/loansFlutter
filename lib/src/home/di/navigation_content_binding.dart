
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customers_binding.dart';
import 'package:loands_flutter/src/home/di/dashboard_binding.dart';
import 'package:loands_flutter/src/home/di/home_calendar_binding.dart';
import 'package:loands_flutter/src/loans/di/loans_binding.dart';

class NavigationContentBinding extends Bindings {
  
  @override
  void dependencies() {
    DashboardBinding().dependencies();
    HomeCalendarBinding().dependencies();
    LoansBinding().dependencies();
    CustomersBinding().dependencies();
  }
}