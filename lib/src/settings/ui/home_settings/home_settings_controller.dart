
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:utils/utils.dart';

class HomeSettingsController extends GetxController {


  void logout() async {
    await UserPreferences().clearAll();
    Get.offAll(() => LoginPage(), binding: LoginBinding());
  }

}