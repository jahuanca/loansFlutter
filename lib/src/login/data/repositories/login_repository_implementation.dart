
import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/domain/datastores/login_datastore.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/login/domain/repositories/login_repository.dart';
import 'package:utils/utils.dart';

class LoginRepositoryImplementation extends LoginRepository {

  LoginDatastore datastore;

  LoginRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<LoginEntity, ErrorEntity>> login(LoginRequest request) {
    return datastore.login(request);
  }
}