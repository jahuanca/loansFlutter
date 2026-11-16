
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

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
    idCustomer: json['idCustomer'],
    ganancy: (json['ganancy'] as num).toDouble(),
    amountOfLoans: json['amountOfLoans'],
    loansInProgress: json['loansInProgress'],
    amountInProgress: (json['amountInProgress'] as num).toDouble(),
    startDate: DateTime.parse(json['startDate']),
    loans: List<LoanEntity>.from(json["loans"].map((x) => LoanEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'idCustomer': idCustomer,
    'ganancy': ganancy,
    'amountOfLoans': amountOfLoans,
    'loansInProgress': loansInProgress,
    'amountInProgress': amountInProgress,
    'startDate': startDate.toServer(),
    'loans': List<dynamic>.from(loans.map((x) => x.toJson())),
  };
}