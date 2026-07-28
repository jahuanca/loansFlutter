import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/data/datastores/login_datastore.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class LoginOnlineDatastore extends LoginDatastore {
  @override
  Future<Result<LoginEntity>> login(LoginRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.post(
      url: '/auth/login',
      body: request.toJson(),
    );

     return executeResponseObject<LoginEntity>(
        response: response, convert: LoginEntity.fromJson);
  }
}