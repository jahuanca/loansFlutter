import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:utils/utils.dart';

class GetLoanUseCase {

  LoanRepository repository;

  GetLoanUseCase({
    required this.repository,
  });

  Future<ResultType<LoanEntity,ErrorEntity>> execute(GetLoanRequest request) {
    return repository.get(request);
  }


}