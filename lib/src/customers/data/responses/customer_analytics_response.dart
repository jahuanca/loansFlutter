
import 'dart:convert';

import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';

class CustomerAnalyticsResponse {

  int idCustomer;
  double ganancy;
  int amountOfLoans;
  DateTime startDate;
  int loansInProgress;
  double amountInProgress;
  List<LoanEntity> loans;

  CustomerAnalyticsResponse({
    required this.idCustomer,
    required this.ganancy,
    required this.amountOfLoans,
    required this.startDate,
    required this.loansInProgress,
    required this.amountInProgress,
    required this.loans,
  });

  factory CustomerAnalyticsResponse.fromJson(Map<String, dynamic> json) => CustomerAnalyticsResponse(
    idCustomer: json['id_customer'],
    ganancy: (json['ganancy'] as num).toDouble(),
    amountOfLoans: json['amount_of_loans'],
    loansInProgress: json['loans_in_progress'],
    amountInProgress: (json['amount_in_progress'] as num).toDouble(),
    startDate: DateTime.parse(json['start_date']),
    loans: List<LoanEntity>.from(json["loans"].map((x) => LoanEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id_customer': idCustomer,
    'ganancy': ganancy,
    'amount_of_loans': amountOfLoans,
    'loans_in_progress': loansInProgress,
    'amount_in_progress': amountInProgress,
    'start_date': startDate,
    'loans': List<dynamic>.from(loans.map((x) => x.toJson())),
  };
}