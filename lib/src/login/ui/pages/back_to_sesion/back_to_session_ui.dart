
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:utils/utils.dart';

class BackToSessionUi {
  ValidateResult<String>? username;
  ValidateResult<String>? password;
  ValidateResult<bool>? keepSesion;

  BackToSessionUi({
    this.username,
    this.keepSesion,
    this.password,
  });

  ValidateResult? validate() {
    return findErrorInValidations([username, password]);
  }

  LoginRequest get loginRequest => LoginRequest(email: username!.value.orEmpty(), password: password!.value.orEmpty());
}