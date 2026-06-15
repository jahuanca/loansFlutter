
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:utils/utils.dart';

abstract class RenewalRepository {
  Future<Result<GetMetadataRenewalResponse,ErrorEntity>> getMetadata(int idCustomer);
  Future<Result<RenewalEntity,ErrorEntity>> add(AddRenewalRequest request);
  Future<Result<PayAndRenewalResponse,ErrorEntity>> payAndRenewal(PayAndRenewalRequest request);
  Future<Result<PayAndRenewalResponse,ErrorEntity>> payAndRenewalSpecial(PayAndRenewalSpecialRequest request);
}