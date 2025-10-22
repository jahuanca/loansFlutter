
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/datastores/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class RenewalRepositoryImplementation extends RenewalRepository{

  RenewalDataStore datastore;

  RenewalRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<PayAndRenewalResponse, ErrorEntity>> payAndRenewal(PayAndRenewalRequest request) {
    return datastore.payAndRenewal(request);
  }

  @override
  Future<ResultType<List<RenewalEntity>, ErrorEntity>> get() {
    return datastore.get();
  }

  @override
  Future<ResultType<RenewalEntity, ErrorEntity>> add(AddRenewalRequest request) {
    return datastore.add(request);
  }

  @override
  Future<ResultType<GetMetadataRenewalResponse, ErrorEntity>> getMetadata(int idCustomer) {
    return datastore.getMetadata(idCustomer);
  }



}