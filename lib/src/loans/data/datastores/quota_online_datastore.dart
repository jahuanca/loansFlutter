import 'dart:convert';

import 'package:loands_flutter/src/loans/domain/datastores/quota_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

class QuotaOnlineDatastore extends QuotaDatastore {
  @override
  Future<ResultType<List<QuotaEntity>, ErrorEntity>> getAll(
      Map<String, dynamic> query) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.get(url: '/quota', query: query);
    if (response.isSuccessful) {
      return Success(data: quotaEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: '',
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<QuotaEntity, ErrorEntity>> getQuota(int idOfQuota) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.get(url: '/quota/$idOfQuota');
    if (response.isSuccessful) {
      return Success(data: QuotaEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: 'Error',
              errorMessage: response.body));
    }
  }
}
