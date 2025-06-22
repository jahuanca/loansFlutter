import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:utils/utils.dart';

class ValidateLoanUseCase {
  LoanRepository repository;

  ValidateLoanUseCase({
    required this.repository,
  });

  Future<ResultType<bool, ErrorEntity>> execute(
      ValidateLoanRequest validateLoanRequest) {
    return repository.validate(validateLoanRequest);
  }
}
