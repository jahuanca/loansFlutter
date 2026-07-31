import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/local_preferences.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:utils/utils.dart';

class LoginController extends GetxController {
  LoginUseCase loginUseCase;
  LoginUi ui = LoginUi();
  String? androidId;

  LoginController({
    required this.loginUseCase,
  });

  @override
  void onInit() {
    ui.username = validateText<String>(text: 'sin valor', label: 'Nombre de usuario');
    ui.keepSesion = ValidateResult.initialize(label: 'Mantener sesión', value: false);
    super.onInit();
  }

  void onChangeUsername(String value) {
    ui.username = validateText<String>(text: value, label: 'Nombre de usuario');
  }

  void onChangePassword(String value) {
    ui.password = validateText<String>(text: value, label: 'Contraseña');
  }

  void onChangeKeepSesion(dynamic value) {
    ui.keepSesion = validateText<bool>(text: value, label: 'Mantener sesión');
    update([keepSesionIdGet]);
  }

  Future<void> goToHome() async {
    ValidateResult? resultValidate = ui.validate();
    if (resultValidate != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: resultValidate.error.orEmpty());
      return;
    }
    showLoading();
    Result<LoginEntity> resultType = await loginUseCase.execute(ui.loginRequest());
    final data = executeResultUI<LoginEntity>(resultType);
    if (data != null) {
      androidId = await getAndroidId();
      LoginEntity loginEntity = data;
      await LocalPreferences()
          .setKeepSesion(ui.keepSesion!.value.orFalse());
      await LocalPreferences().setEmail(ui.username!.value.orEmpty());
      await UserPreferences().setToken(loginEntity.token);
      Get.off(() => NavigationContentPage(),
          binding: NavigationContentBinding());
    }
    hideLoading();
  }
}
