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
  Future<ResultType<List<QuotaEntity>, ErrorEntity>> getAll(Map<String, dynamic> query) async {
    return datastore.getAll(query);
  }

}