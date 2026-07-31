
import 'package:utils/utils.dart';

class UpdatePasswordUi {
  ValidateResult<String>? currentPassword,
    newPassword,
    repeatPassword;

  UpdatePasswordUi({
    this.currentPassword,
    this.newPassword,
    this.repeatPassword,
  });

  ValidateResult? validate() {
    final error = findErrorInValidations([currentPassword, newPassword, repeatPassword]);
    if(error != null) {
      return error;
    }

    if (newPassword?.value != repeatPassword?.value) {
      return ValidateResult(label: 'Repetir contraseña', value: repeatPassword!.value, error: 'Contraseñas no coinciden', hasError: true);
    }
    return null;
  }
}