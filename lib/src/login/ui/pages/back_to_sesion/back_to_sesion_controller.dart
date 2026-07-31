import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_session_ui.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/direct_access_enum.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/utils/core/feature_flag/feature_flag_service.dart';
import 'package:loands_flutter/src/utils/core/feature_flag/flags.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/local_preferences.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:utils/utils.dart';

class BackToSesionController extends GetxController {
  LoginUseCase loginUseCase;
  BackToSessionUi ui = BackToSessionUi();
  DirectAccessEnum? directAccessSelected;

  BackToSesionController({
    required this.loginUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    ui.username = ValidateResult.initialize(
      label: nameString,
      value: LocalPreferences().email().orEmpty(),
    );
    ui.password = ValidateResult.pending(label: 'Password');
    ui.keepSesion =
        ValidateResult.initialize(label: 'Mantener sesion', value: true);
  }

  void onChangePassword(String value) {
    ui.password = validateText<String>(text: value, label: 'Contraseña');
  }

  void goToLogin() {
    Get.to(() => LoginPage());
  }

  void goToHome() async {
    ValidateResult? resultValidate = ui.validate();
    if (resultValidate != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: resultValidate.error.orEmpty());
      return;
    }

    bool isEnabled = checkFeatureFlag(Flag.secondLogin);
    if (isEnabled.not()) {
      showAlertWidget(
          context: Get.context!,
          message:
              'Este servicio no se encuentra activo, vuelva a intentar en unos minutos.');
      return;
    }

    showLoading();
    Result<LoginEntity> resultType =
        await loginUseCase.execute(ui.loginRequest);
    final data = executeResultUI<LoginEntity>(resultType);
    if (data != null) {
      String? androidId = await getAndroidId();
      LoginEntity loginEntity = data;
      await LocalPreferences().setKeepSesion(ui.keepSesion!.value.orFalse());
      await UserPreferences().setToken(loginEntity.token);
      Get.off(() => NavigationContentPage(),
          binding: NavigationContentBinding());
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
        goToHome();
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
