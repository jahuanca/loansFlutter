
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:utils/utils.dart';

abstract class RenewalDataStore {
  Future<Result<GetMetadataRenewalResponse>> getMetadata(int idCustomer);
  Future<Result<RenewalEntity>> add(AddRenewalRequest request);
  Future<Result<PayAndRenewalResponse>> payAndRenewal(PayAndRenewalRequest request);
  Future<Result<PayAndRenewalResponse>> payAndRenewalSpecial(PayAndRenewalSpecialRequest request);
}