
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';

class PayAndRenewalResponse {

  QuotaEntity quota;
  LoanEntity loan;

  PayAndRenewalResponse({
    required this.quota,
    required this.loan,
  });

  factory PayAndRenewalResponse.fromJson(Map<String, dynamic> json) => PayAndRenewalResponse(
    quota: QuotaEntity.fromJson(json['quota']), 
    loan: LoanEntity.fromJson(json['loan']));

  Map<String, dynamic> toJson() => {
    'quota': quota.toJson(),
    'loan': loan.toJson(),
  };

}