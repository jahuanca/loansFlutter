import 'dart:convert';

import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/datastores/loan_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:utils/utils.dart';

class LoanOnlineDatastore extends LoanDatastore {
  @override
  Future<ResultType<LoanEntity, ErrorEntity>> create(
      AddLoanRequest addLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create', body: addLoanRequest.toJson());
    if (response.isSuccessful) {
      return Success(data: LoanEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<List<LoanEntity>, ErrorEntity>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(
      url: '/loan', query: {
        'id_state_loan': idOfPendingLoan,
      }
    );
    if (response.isSuccessful) {
      return Success(data: loanEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<LoanEntity, ErrorEntity>> createSpecial(
      AddSpecialLoanRequest addSpecialLoanRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.post(
        url: '/loan/create-special', body: addSpecialLoanRequest.toJson());
    if (response.isSuccessful) {
      return Success(data: LoanEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}
