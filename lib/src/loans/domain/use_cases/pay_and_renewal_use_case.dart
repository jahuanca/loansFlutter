
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/repositories/renewal_repository.dart';
import 'package:utils/utils.dart';

class PayAndRenewalUseCase {

  RenewalRepository repository;

  PayAndRenewalUseCase(this.repository);

  Future<ResultType<PayAndRenewalResponse, ErrorEntity>> execute(PayAndRenewalRequest request) {
    return repository.payAndRenewal(request);
  }

}