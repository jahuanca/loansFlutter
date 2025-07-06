
import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/quota_repository.dart';
import 'package:utils/utils.dart';

class GetAllQuotasUseCase {

  QuotaRepository repository;

  GetAllQuotasUseCase({
    required this.repository,
  });

    Future<ResultType<List<QuotaEntity>,ErrorEntity>> execute(GetAllQuotasRequest request){
      return repository.getAll(request);
    }


}