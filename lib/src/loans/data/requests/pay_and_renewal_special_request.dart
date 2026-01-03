
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';

class PayAndRenewalSpecialRequest {

  int? idCustomer;
  int? idPaymentFrequency;
  int? idPaymentMethod;
  double? percentage;
  double? amount;
  double? ganancy;
  DateTime? startDate;
  int? numberOfInstallments;
  int? daysBetweenInstallments;

  int? idLoanToRenew;
  DateTime? paidDate;
  int? idOfQuota;

  CustomerEntity? customerEntity;
  PaymentMethodEntity? paymentMethodEntity;
  PaymentFrequencyEntity? paymentFrequencyEntity;

  PayAndRenewalSpecialRequest({
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
    this.daysBetweenInstallments,
    this.numberOfInstallments,
  });


  factory PayAndRenewalSpecialRequest.fromJson(Map<String, dynamic> json) => PayAndRenewalSpecialRequest(
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
    daysBetweenInstallments: json['days_between_installments'],
    numberOfInstallments: json['number_of_installments'],
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
    'number_of_installments': numberOfInstallments,
    'days_between_installments': daysBetweenInstallments,
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
    'number_of_installments': numberOfInstallments,
    'days_between_installments': daysBetweenInstallments,

    'customerEntity': customerEntity?.toJson(),
    'paymentFrequencyEntity': paymentFrequencyEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  }; 
}