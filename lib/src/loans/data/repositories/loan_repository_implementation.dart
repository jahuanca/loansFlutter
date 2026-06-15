
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:utils/utils.dart';

class LoanRepositoryImplementation extends LoanRepository {

  LoanDatastore datastore;

  LoanRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<Result<LoanEntity, ErrorEntity>> create(AddLoanRequest addLoanRequest) {
    return datastore.create(addLoanRequest);
  }
  
  @override
  Future<Result<List<LoanEntity>, ErrorEntity>> getAll(GetLoansRequest request) {
    return datastore.getAll(request);
  }

  @override
  Future<Result<LoanEntity, ErrorEntity>> createSpecial(AddSpecialLoanRequest addSpecialLoanRequest) {
    return datastore.createSpecial(addSpecialLoanRequest);
  }
  
  @override
  Future<Result<bool, ErrorEntity>> validate(ValidateLoanRequest validateLoanRequest) {
    return datastore.validate(validateLoanRequest);
  }
  
  @override
  Future<Result<LoanEntity, ErrorEntity>> get(GetLoanRequest request) {
    return datastore.get(request);
  }
}