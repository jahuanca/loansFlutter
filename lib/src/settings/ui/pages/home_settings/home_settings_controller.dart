import 'package:get/get.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/settings/di/settings_binding.dart';
import 'package:loands_flutter/src/settings/ui/pages/settings_option_enum.dart';
import 'package:loands_flutter/src/settings/ui/pages/update_password/update_password_page.dart';
import 'package:loands_flutter/src/utils/ui/pages/video_player/video_page.dart';
import 'package:utils/utils.dart';

class HomeSettingsController extends GetxController {

  void _logout() async {
    await UserPreferences().clearAll();
    Get.offAll(() => LoginPage(), binding: LoginBinding());
  }

  void goLogout() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Está seguro de cerrar sesión?');
    if (result) _logout();
  }

  Future<void> goToUpdatePassword() async {
    final result = await Get.to<SettingsOptionEnum>(()=> UpdatePasswordPage(), binding: SettingsBinding());

    if (result != null) {
      showSnackbarWidget(
        context: Get.context!, 
        typeSnackbar: TypeSnackbar.success, 
        message: result.messageSuccess);
    }
  }

   void goVideo() async {
    Get.to(()=> const VideoPage());
  }
}
