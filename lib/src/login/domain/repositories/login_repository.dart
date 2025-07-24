
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:utils/utils.dart';

abstract class LoginRepository {
  Future<ResultType<LoginEntity, ErrorEntity>> login(LoginRequest request);
}