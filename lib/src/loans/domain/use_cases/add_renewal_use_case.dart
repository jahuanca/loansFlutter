
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class AddRenewalUseCase {

  RenewalRepository repository;

  AddRenewalUseCase({
    required this.repository,
  });

  Future<ResultType<RenewalEntity, ErrorEntity>> execute(AddRenewalRequest request) {
    return repository.add(request);
  }

}