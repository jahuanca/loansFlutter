
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

abstract class LoanDatastore {
  Future<ResultType<LoanEntity,ErrorEntity>> create(AddLoanRequest addLoanRequest);
  Future<ResultType<List<LoanEntity>,ErrorEntity>> getAll();
}