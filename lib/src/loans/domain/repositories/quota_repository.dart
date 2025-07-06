import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class QuotaRepository {
  
  Future<ResultType<List<QuotaEntity>,ErrorEntity>> getAll(GetAllQuotasRequest request);
  
  Future<ResultType<QuotaEntity,ErrorEntity>> getQuota(int idOfQuota);
}