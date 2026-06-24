
import 'package:utils/utils.dart';

class UpdatePasswordUi {
  ValidateResult? currentPassword;
  ValidateResult? newPassword;
  ValidateResult? repeatPassword;

  UpdatePasswordUi({
    this.currentPassword,
    this.newPassword,
    this.repeatPassword,
  });

  String? validate() {
    if (currentPassword?.hasError ?? true) {
      return currentPassword?.error;
    }

    if (newPassword?.hasError ?? true) {
      return newPassword?.error;
    }

    if (repeatPassword?.hasError ?? true) {
      return repeatPassword?.error;
    }

    if (newPassword?.value != repeatPassword?.value) {
      return 'Contraseñas no coinciden';
    }

    return null;
  }
}