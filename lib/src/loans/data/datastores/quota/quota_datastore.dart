import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class QuotaDatastore {

  Future<Result<List<QuotaEntity>>> getAll(GetAllQuotasRequest request);

  Future<Result<QuotaEntity>> getQuota(int idOfQuota);
}