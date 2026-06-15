import 'package:get/get.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:utils/utils.dart';

class LoginController extends GetxController {
  LoginUseCase loginUseCase;
  ValidateResult? username;
  ValidateResult? password;

  LoginController({
    required this.loginUseCase,
  });

  void onChangeUsername(String value) {
    username = validateText(text: value, label: 'Nombre de usuario');
  }

  void onChangePassword(String value) {
    password = validateText(text: value, label: 'Contraseña');
  }

  void goToHome() async {
    ValidateResult? validateResult =
        findErrorInValidations([username, password]);

    if (validateResult != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: validateResult.error.orEmpty());
      return;
    }
    showLoading();
    LoginRequest request =
        LoginRequest(email: username!.value, password: password!.value);
    Result<LoginEntity, ErrorEntity> resultType =
        await loginUseCase.execute(request);
    switch (resultType) {
      case Success():
      LoginEntity loginEntity = resultType.value;
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
