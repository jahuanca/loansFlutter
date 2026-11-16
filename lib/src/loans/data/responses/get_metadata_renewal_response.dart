import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';

class GetMetadataRenewalResponse {
  List<LoanEntity> previousLoans;
  List<LoanEntity> newLoans;

  GetMetadataRenewalResponse({
    required this.previousLoans,
    required this.newLoans,
  });

  factory GetMetadataRenewalResponse.fromJson(Map<String, dynamic> json) =>
      GetMetadataRenewalResponse(
        previousLoans: List<LoanEntity>.from(json['previousLoans'].map((e) => LoanEntity.fromJson(e))).toList(),
        newLoans: List<LoanEntity>.from(json['newLoans'].map((e) => LoanEntity.fromJson(e))).toList(),
      );

  Map<String, dynamic> toJson() => {
        'previousLoans': previousLoans.map((e) => e.toJson()).toList(),
        'newLoans': newLoans.map((e) => e.toJson()).toList(),
      };
}
