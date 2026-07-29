import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/data/datastores/loan/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:utils/utils.dart';

class LoanOnlineDatastore extends LoanDatastore {
  @override
  Future<Result<LoanEntity>> create(
      AddLoanRequest addLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create', body: addLoanRequest.toJson());
    
    return executeResponseObject<LoanEntity>(
        response: response, convert: LoanEntity.fromJson);
  }

  @override
  Future<Result<List<LoanEntity>>> getAll(GetLoansRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/loan', query: request.toJson());

    return executeResponseList<LoanEntity>(
        response: response, 
        convert: loanEntityFromJson, 
        sourceHiveDb: HiveDbAdapters.loans.source,
    );
  }

  @override
  Future<Result<LoanEntity>> createSpecial(
      AddSpecialLoanRequest addSpecialLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create-special', body: addSpecialLoanRequest.toJson());
    return executeResponseObject<LoanEntity>(
        response: response, convert: LoanEntity.fromJson);
  }

  @override
  Future<Result<bool>> validate(
      ValidateLoanRequest validateLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/validate', body: validateLoanRequest.toJson());
    switch (response) {
      case Success():
        final value = response.value;
        if (value.isSuccessful) {
          return Result.success(true);
        } else {
          return Result.error(ErrorEntity(errorMessage: value.detail, title: value.title, statusCode: value.statusCode));
        }

      case Error():
        return Result.error(response.error);
    }
  }
  
  @override
  Future<Result<LoanEntity>> get(GetLoanRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/loan/id/${request.id}');
    return executeResponseObject<LoanEntity>(
        response: response, convert: LoanEntity.fromJson);
  }
}
