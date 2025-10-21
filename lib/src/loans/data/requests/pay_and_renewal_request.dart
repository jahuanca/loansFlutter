
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';

class PayAndRenewalRequest {

  int? idCustomer;
  int? idPaymentFrequency;
  int? idPaymentMethod;
  double? percentage;
  double? amount;
  double? ganancy;
  DateTime? startDate;

  int? idLoanToRenew;
  DateTime? paidDate;
  int? idOfQuota;

  CustomerEntity? customerEntity;
  PaymentMethodEntity? paymentMethodEntity;
  PaymentFrequencyEntity? paymentFrequencyEntity;

  PayAndRenewalRequest({
    this.idCustomer,
    this.idPaymentFrequency,
    this.idPaymentMethod,
    this.percentage,
    this.amount,
    this.ganancy,
    this.startDate,
    this.customerEntity,
    this.paymentFrequencyEntity,
    this.paymentMethodEntity,
    this.idLoanToRenew,
    this.paidDate,
    this.idOfQuota,
  });


  factory PayAndRenewalRequest.fromJson(Map<String, dynamic> json) => PayAndRenewalRequest(
    idCustomer: json['id_customer'],
    idPaymentFrequency: json['id_payment_frequency'],
    idPaymentMethod: json['id_payment_method'],
    percentage: json['percentage'],
    amount: json['amount'],
    ganancy: json['ganancy'],
    startDate: DateTime.parse(json['start_date']),
    idLoanToRenew: json['id_loan_to_renew'],
    paidDate: DateTime.parse(json['paid_date']),
    idOfQuota: json['id_of_quota'],
  );

  Map<String, dynamic> toApi() => {
    'id_customer': idCustomer,
    'id_payment_frequency': idPaymentFrequency,
    'id_payment_method': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'start_date': startDate?.toIso8601String(),
    'id_loan_to_renew': idLoanToRenew,
    'paid_date': paidDate?.toIso8601String(),
    'id_of_quota': idOfQuota,
  };
  
  Map<String, dynamic> toJson() => {
    'id_customer': idCustomer,
    'id_payment_frequency': idPaymentFrequency,
    'id_payment_method': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'start_date': startDate?.toIso8601String(),
    'id_loan_to_renew': idLoanToRenew,
    'paid_date': paidDate?.toIso8601String(),
    'id_of_quota': idOfQuota,

    'customerEntity': customerEntity?.toJson(),
    'paymentFrequencyEntity': paymentFrequencyEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  }; 
}