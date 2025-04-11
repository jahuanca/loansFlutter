
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(()=>LoginController());
    Get.create(()=>DashboardController());
  }

}