
import 'package:get/get.dart';
import 'package:loands_flutter/src/users/ui/pages/users/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => UsersController(),);
  }

}