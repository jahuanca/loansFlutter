
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/repositories/login_repository.dart';
import 'package:utils/utils.dart';

class LoginUseCase {

  LoginRepository repository;

  LoginUseCase({
    required this.repository
  });

  Future<ResultType<LoginEntity, ErrorEntity>> execute(LoginRequest request) {
    return repository.login(request);
  }

}