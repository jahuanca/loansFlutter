
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
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
  Future<ResultType<LoanEntity, ErrorEntity>> create(AddLoanRequest addLoanRequest) {
    return datastore.create(addLoanRequest);
  }
  
  @override
  Future<ResultType<List<LoanEntity>, ErrorEntity>> getAll() {
    return datastore.getAll();
  }

  @override
  Future<ResultType<LoanEntity, ErrorEntity>> createSpecial(AddSpecialLoanRequest addSpecialLoanRequest) {
    return datastore.createSpecial(addSpecialLoanRequest);
  }
  
  @override
  Future<ResultType<bool, ErrorEntity>> validate(AddLoanRequest addLoanRequest) {
    return datastore.validate(addLoanRequest);
  }
}