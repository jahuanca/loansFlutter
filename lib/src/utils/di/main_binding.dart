import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/dashboard_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    DashboardBinding().dependencies();
    Get.create(() => LoginController());
  }
}
