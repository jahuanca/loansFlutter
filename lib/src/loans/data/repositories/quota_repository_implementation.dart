import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/datastores/quota_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/quota_repository.dart';
import 'package:utils/utils.dart';

class QuotaRepositoryImplementation extends QuotaRepository {

  QuotaDatastore datastore;

  QuotaRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<List<QuotaEntity>, ErrorEntity>> getAll(GetAllQuotasRequest request) {
    return datastore.getAll(request);
  }
  
  @override
  Future<ResultType<QuotaEntity, ErrorEntity>> getQuota(int idOfQuota) {
    return datastore.getQuota(idOfQuota);
  }
}