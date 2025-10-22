
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class GetMetadataRenewalUseCase {

  RenewalRepository repository;

  GetMetadataRenewalUseCase(this.repository);

  Future<ResultType<GetMetadataRenewalResponse, ErrorEntity>> execute(int idCustomer) {
    return repository.getMetadata(idCustomer);
  }

}