import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    NavigationContentBinding().dependencies();
    LoginBinding().dependencies();
  }
}
