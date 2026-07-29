
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/domain/use_cases/update_password_use_case.dart';
import 'package:loands_flutter/src/settings/ui/pages/settings_option_enum.dart';
import 'package:loands_flutter/src/settings/ui/pages/update_password/update_password_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class UpdatePasswordController extends GetxController {

  UpdatePasswordUseCase updatePasswordUseCase;
  UpdatePasswordUi ui = UpdatePasswordUi();

  UpdatePasswordController({
    required this.updatePasswordUseCase,
  });

  void onChangedCurrentPassword(dynamic value) {
    ui.currentPassword = validateText(text: value, label: 'Actual');
  }

  void onChangedNewPassword(dynamic value) {
    ui.newPassword = validateText(
      text: value,
      label: 'Nueva',
      rules: {
        RuleValidator.isRequired: true,
      }
      );
  }

  void onChangedRepeatPassword(dynamic value) {
    ui.repeatPassword = validateText(text: value, label: 'Repetida');
  }

  Future<void> goToUpdatePassword() async {
    final message = ui.validate();
    if (message != null) {
      showSnackbarWidget(
        context: Get.context!, 
        typeSnackbar: TypeSnackbar.error, 
        message: message.error.orEmpty(),
      );
      return;
    }
    bool result = await showDialogWidget(
      context: Get.context!, 
      message: '¿Esta seguro de actualizar su contraseña?');
    if (result) {
      _updatePassword();
    }
  }


  Future<void> _updatePassword() async {
    showLoading();
    Result<void> resultType = 
      await updatePasswordUseCase.execute(
        ui.currentPassword!.value.orEmpty(), 
        ui.newPassword!.value.orEmpty(), 
      );
    hideLoading();
    final data = await executeResultUI<dynamic>(resultType);
    if (data != null) {
      Get.back(result: SettingsOptionEnum.changePassword);
    }
  }

}