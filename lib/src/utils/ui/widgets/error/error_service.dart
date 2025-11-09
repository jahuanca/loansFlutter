import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class ErrorService extends GetxService {
  bool isShowing = false;

  void show({
    required BuildContext context,
    required ErrorEntity errorEntity,
  }) async {
    if (isLoading()) hideLoading();
    if (isShowing) return;

    isShowing = true;
    switch (errorEntity.statusCode) {
      case 422:
        bool result = await showAlertWidget(
            context: context,
            message: 'Token vencido, debe volver a iniciar sesión.');
        if (result) {
          // ignore: use_build_context_synchronously
          _goToLogin(context);
        }
        break;
      default:
        showSnackbarWidget(
          context: context, 
          typeSnackbar: TypeSnackbar.error, 
          message: errorEntity.title
        );
        break;
    }
  }

  void _goToLogin(BuildContext context) async {
    await UserPreferences().clearAll();
    if (!context.mounted) return;
    LoginBinding().dependencies();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  void hide() {
    if (!isShowing) return;
    isShowing = false;
  }
}

void showError({
  required BuildContext context,
  required ErrorEntity errorEntity,
}) =>
    Get.find<ErrorService>().show(context: context, errorEntity: errorEntity);
void hideError() => Get.find<ErrorService>().hide();
bool isShowingError() => Get.find<ErrorService>().isShowing;
