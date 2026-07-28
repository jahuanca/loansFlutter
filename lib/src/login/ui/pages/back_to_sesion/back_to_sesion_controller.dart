import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/direct_access_enum.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/local_preferences.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:utils/utils.dart';

class BackToSesionController extends GetxController {
  LoginUseCase loginUseCase;
  late String username = '';
  LoginUi loginUi = LoginUi();
  DirectAccessEnum? directAccessSelected;

  BackToSesionController({
    required this.loginUseCase,
  });

  @override
  void onInit() {
    username = LocalPreferences().email().orEmpty();
    loginUi = LoginUi(
      username: ValidateResult(value: username, hasError: false),
      keepSesion: ValidateResult(value: true, hasError: false),
    );

    super.onInit();
  }

  void onChangePassword(String value) {
    loginUi.password = validateText(text: value, label: 'Contraseña');
  }

  void goToLogin() {
    Get.to(LoginPage());
  }

  void goToHome() async {
    final resultValidate = loginUi.validate();
    if (resultValidate != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: resultValidate.error.orEmpty());
      return;
    }
    showLoading();
    Result<LoginEntity> resultType =
        await loginUseCase.execute(loginUi.value);
    switch (resultType) {
      case Success():
        String? androidId = await getAndroidId();
        LoginEntity loginEntity = resultType.value;
        await LocalPreferences().setKeepSesion(loginUi.keepSesion?.value);
        await UserPreferences().setToken(loginEntity.token);
        Get.off(() => NavigationContentPage(),
            binding: NavigationContentBinding());
        break;
      case Error():
        break;
    }
    hideLoading();
  }

  Future<void> checkFinger() async {
    final LocalAuthentication auth = LocalAuthentication();
    if (await isSupported()) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      }

      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face)) {
        // Specific types of biometrics are available.
        // Use checks like this with caution!
      }
    } else {
      showDialogWidget(context: Get.context!, message: 'No esta habilidado');
    }
  }

  void onChangedDirectAccess(DirectAccessEnum value) {
    if (directAccessSelected == value) {
      directAccessSelected = null;
    } else {
      directAccessSelected = value;
    }
    update([directAccessIdGet]);
  }
}
