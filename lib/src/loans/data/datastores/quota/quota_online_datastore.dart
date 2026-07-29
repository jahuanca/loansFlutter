
import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/data/datastores/quota/quota_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class QuotaOnlineDatastore extends QuotaDatastore {
  @override
  Future<Result<List<QuotaEntity>>> getAll(
      GetAllQuotasRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/quota', query: request.toJson());
    return executeResponseList<QuotaEntity>(
        response: response, convert: quotaEntityFromJson);
  }

  @override
  Future<Result<QuotaEntity>> getQuota(int idOfQuota) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/quota/$idOfQuota');
     return executeResponseObject<QuotaEntity>(
        response: response, convert: QuotaEntity.fromJson);
  }
}
