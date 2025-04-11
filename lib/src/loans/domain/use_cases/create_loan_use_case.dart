import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:utils/utils.dart';

class CreateLoanUseCase {
  LoanRepository repository;

  CreateLoanUseCase({
    required this.repository,
  });

  Future<ResultType<LoanEntity, ErrorEntity>> execute(
      AddLoanRequest addLoanRequest) {
    return repository.create(addLoanRequest);
  }
}
