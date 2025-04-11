
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_page.dart';

class LoginController extends GetxController {

  void goToHome(){
    Get.to(()=> const DashboardPage());
  }
}