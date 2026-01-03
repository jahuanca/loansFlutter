
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class PayAndRenewalSpecialUseCase {

  RenewalRepository repository;

  PayAndRenewalSpecialUseCase(this.repository);

  Future<ResultType<PayAndRenewalResponse, ErrorEntity>> execute(PayAndRenewalSpecialRequest request) {
    return repository.payAndRenewalSpecial(request);
  }

}