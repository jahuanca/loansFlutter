
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_datastore.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:utils/utils.dart';

class LoanOfflineDatastore extends LoanDatastore {
  @override
  Future<Result<LoanEntity>> create(AddLoanRequest addLoanRequest) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Result<LoanEntity>> createSpecial(AddSpecialLoanRequest addSpecialLoanRequest) {
    // TODO: implement createSpecial
    throw UnimplementedError();
  }

  @override
  Future<Result<LoanEntity>> get(GetLoanRequest request) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Result<List<LoanEntity>>> getAll(GetLoansRequest request) async {
    final data = await Hive.openBox<LoanEntity>(HiveDbAdapters.loans.source);
    final values = data.values;
    await data.close();
    return Result.success(values.toList());
  }

  @override
  Future<Result<bool>> validate(ValidateLoanRequest validateLoanRequest) {
    throw UnimplementedError();
  }

}