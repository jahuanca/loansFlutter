
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_offline_datastore.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_online_datastore.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/repositories/loan_repository.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class LoanRepositoryImplementation extends LoanRepository {

  LoanOnlineDatastore onlineDatastore;
  LoanOfflineDatastore offlineDatastore;

  LoanRepositoryImplementation({
    required this.onlineDatastore,
    required this.offlineDatastore,
  });

  @override
  Future<Result<LoanEntity>> create(AddLoanRequest addLoanRequest) {
    return onlineDatastore.create(addLoanRequest);
  }
  
  @override
  Future<Result<List<LoanEntity>>> getAll(GetLoansRequest request) async {
    if (await isConnected) {
      return onlineDatastore.getAll(request); 
    }
    return offlineDatastore.getAll(request);
  }

  @override
  Future<Result<LoanEntity>> createSpecial(AddSpecialLoanRequest addSpecialLoanRequest) {
    return onlineDatastore.createSpecial(addSpecialLoanRequest);
  }
  
  @override
  Future<Result<bool>> validate(ValidateLoanRequest validateLoanRequest) {
    return onlineDatastore.validate(validateLoanRequest);
  }
  
  @override
  Future<Result<LoanEntity>> get(GetLoanRequest request) {
    return onlineDatastore.get(request);
  }
}