
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class RenewalRepositoryImplementation extends RenewalRepository {

  RenewalDataStore datastore;

  RenewalRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<Result<PayAndRenewalResponse>> payAndRenewal(PayAndRenewalRequest request) {
    return datastore.payAndRenewal(request);
  }

  @override
  Future<Result<RenewalEntity>> add(AddRenewalRequest request) {
    return datastore.add(request);
  }

  @override
  Future<Result<GetMetadataRenewalResponse>> getMetadata(int idCustomer) {
    return datastore.getMetadata(idCustomer);
  }

  @override
  Future<Result<PayAndRenewalResponse>> payAndRenewalSpecial(PayAndRenewalSpecialRequest request) {
    return datastore.payAndRenewalSpecial(request);
  }
}