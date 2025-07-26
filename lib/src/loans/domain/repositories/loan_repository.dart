
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

abstract class LoanRepository {
  Future<ResultType<bool,ErrorEntity>> validate(ValidateLoanRequest validateLoanRequest);
  Future<ResultType<LoanEntity,ErrorEntity>> create(AddLoanRequest addLoanRequest);
  Future<ResultType<LoanEntity,ErrorEntity>> createSpecial(AddSpecialLoanRequest addSpecialLoanRequest);
  Future<ResultType<List<LoanEntity>,ErrorEntity>> getAll(GetLoansRequest request);
}