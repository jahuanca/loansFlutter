
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/quota_repository.dart';
import 'package:utils/utils.dart';

class GetAllQuotasUseCase {

  QuotaRepository repository;

  GetAllQuotasUseCase({
    required this.repository,
  });

    Future<ResultType<QuotaEntity,ErrorEntity>> execute(int idOfQuota){
      return repository.getQuota(idOfQuota);
    }


}