import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/ui/pages/home_chat/home_chat_page.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/settings/di/settings_binding.dart';
import 'package:loands_flutter/src/settings/ui/pages/home_settings/home_settings_enum.dart';
import 'package:loands_flutter/src/settings/ui/pages/settings_option_enum.dart';
import 'package:loands_flutter/src/settings/ui/pages/update_password/update_password_page.dart';
import 'package:loands_flutter/src/utils/ui/pages/routes_app.dart';
import 'package:loands_flutter/src/utils/ui/pages/video_player/video_page.dart';
import 'package:utils/utils.dart';

class HomeSettingsController extends GetxController {

  void _logout() async {
    await UserPreferences().clearAll();
    Get.offAll(() => LoginPage(), binding: LoginBinding());
  }

  void _goLogout() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Está seguro de cerrar sesión?');
    if (result) _logout();
  }

  Future<void> goToEventEnum(HomeSettingsEnum value) async {
    switch (value) {
      case HomeSettingsEnum.changeEmail:
        
        break;
      case HomeSettingsEnum.changePassword:
        _goToUpdatePassword();
        break;
      case HomeSettingsEnum.viewTutorial:
        _goVideo();
        break;
      case HomeSettingsEnum.chat:
        _goChats();
        break;
      case HomeSettingsEnum.logout:
        _goLogout();
        break;
      case HomeSettingsEnum.exit:
        RoutesApp.goToBackToSesion();
        break;
    }
  }

  Future<void> _goToUpdatePassword() async {
    final result = await Get.to<SettingsOptionEnum>(()=> UpdatePasswordPage(), binding: SettingsBinding());

    if (result != null) {
      showSnackbarWidget(
        context: Get.context!, 
        typeSnackbar: TypeSnackbar.success, 
        message: result.messageSuccess);
    }
  }

  void _goVideo() async {
    Get.to(() => const VideoPage());
  }

  void _goChats() {
    Get.to(() => HomeChatPage());
  }

}
