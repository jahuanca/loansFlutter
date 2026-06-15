import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class QuotaRepository {
  
  Future<Result<List<QuotaEntity>,ErrorEntity>> getAll(GetAllQuotasRequest request);
  
  Future<Result<QuotaEntity,ErrorEntity>> getQuota(int idOfQuota);
}