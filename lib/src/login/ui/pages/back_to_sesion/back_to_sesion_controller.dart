
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/local_preferences.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class BackToSesionController extends GetxController {

  LoginUseCase loginUseCase;
  LoginUi loginUi = LoginUi();

  BackToSesionController({
    required this.loginUseCase,
  });

    @override
  void onInit() {
    loginUi = LoginUi(
      username: ValidateResult(value: 'huancaancajima@gmail.com', hasError: false),
      keepSesion: ValidateResult(value: true, hasError: false),
    );

    super.onInit();
  }

  void onChangePassword(String value) {
    loginUi.password = validateText(text: value, label: 'Contraseña');
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
    Result<LoginEntity, ErrorEntity> resultType =
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
}