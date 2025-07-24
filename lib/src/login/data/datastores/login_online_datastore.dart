
import 'dart:convert';

import 'package:loands_flutter/src/login/data/request/login_request.dart';
import 'package:loands_flutter/src/login/domain/datastores/login_datastore.dart';
import 'package:loands_flutter/src/login/domain/entities/login_entity.dart';
import 'package:utils/utils.dart';

class LoginOnlineDatastore extends LoginDatastore {
  @override
  Future<ResultType<LoginEntity, ErrorEntity>> login(LoginRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.post(
      url: '/auth/login',
      body: request.toJson(),
    );
    if (response.isSuccessful) {
      return Success(data: LoginEntity.fromJson(
        jsonDecode(response.body)
      ));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}