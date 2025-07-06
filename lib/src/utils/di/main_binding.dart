import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    NavigationContentBinding().dependencies();
    Get.lazyPut(() => LoginController());
  }
}
