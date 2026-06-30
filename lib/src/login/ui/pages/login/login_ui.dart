
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:utils/utils.dart';

class LoginUi {
  ValidateResult? username;
  ValidateResult? password;
  ValidateResult? keepSesion = ValidateResult(value: false);

  LoginUi({
    this.username,
    this.password,
    this.keepSesion,
  });

  ValidateResult? validate() {
    return findErrorInValidations([username, password]);
  }

  LoginRequest get value => LoginRequest(email: username?.value, password: password?.value);
}