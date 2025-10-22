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
        previousLoans: List<LoanEntity>.from(json['previous_loans'].map((e) => LoanEntity.fromJson(e))).toList(),
        newLoans: List<LoanEntity>.from(json['new_loans'].map((e) => LoanEntity.fromJson(e))).toList(),
      );

  Map<String, dynamic> toJson() => {
        'previous_loans': previousLoans.map((e) => e.toJson()).toList(),
        'new_loans': newLoans.map((e) => e.toJson()).toList(),
      };
}
