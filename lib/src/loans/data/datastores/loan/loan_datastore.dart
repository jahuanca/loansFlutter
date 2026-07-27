import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

abstract class LoanDatastore {
  Future<Result<bool, ErrorEntity>> validate(ValidateLoanRequest validateLoanRequest);
  Future<Result<LoanEntity, ErrorEntity>> create(
      AddLoanRequest addLoanRequest);
  Future<Result<LoanEntity, ErrorEntity>> createSpecial(
      AddSpecialLoanRequest addSpecialLoanRequest);
  Future<Result<List<LoanEntity>, ErrorEntity>> getAll(GetLoansRequest request);
  Future<Result<LoanEntity,ErrorEntity>> get(GetLoanRequest request);
}
