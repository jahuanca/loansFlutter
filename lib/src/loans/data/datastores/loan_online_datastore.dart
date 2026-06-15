import 'dart:convert';

import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

class LoanOnlineDatastore extends LoanDatastore {
  @override
  Future<Result<LoanEntity, ErrorEntity>> create(
      AddLoanRequest addLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create', body: addLoanRequest.toJson());
    if (response.isSuccessful) {
      return Success( LoanEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<List<LoanEntity>, ErrorEntity>> getAll(GetLoansRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/loan', query: request.toJson());
    if (response.isSuccessful) {
      return Success( loanEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<LoanEntity, ErrorEntity>> createSpecial(
      AddSpecialLoanRequest addSpecialLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create-special', body: addSpecialLoanRequest.toJson());
    if (response.isSuccessful) {
      return Success( LoanEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<bool, ErrorEntity>> validate(
      ValidateLoanRequest validateLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/validate', body: validateLoanRequest.toJson());
    if (response.isSuccessful) {
      return Success( jsonDecode(response.body) as bool);
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
  
  @override
  Future<Result<LoanEntity, ErrorEntity>> get(GetLoanRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/loan/id/${request.id}');
    if (response.isSuccessful) {
      return Success( LoanEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}
