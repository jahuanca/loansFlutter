import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:utils/utils.dart';

class GetLoansUseCase {

  LoanRepository repository;

  GetLoansUseCase({
    required this.repository,
  });

  Future<ResultType<List<LoanEntity>,ErrorEntity>> execute() {
    return repository.getAll();
  }


}