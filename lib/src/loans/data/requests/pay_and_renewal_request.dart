
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:utils/utils.dart';

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
    idCustomer: json['idCustomer'],
    idPaymentFrequency: json['idPaymentFrequency'],
    idPaymentMethod: json['idPaymentMethod'],
    percentage: json['percentage'],
    amount: json['amount'],
    ganancy: json['ganancy'],
    startDate: DateTime.parse(json['startDate']),
    idLoanToRenew: json['idLoanToRenew'],
    paidDate: DateTime.parse(json['paidDate']),
    idOfQuota: json['idOfQuota'],
  );

  Map<String, dynamic> toApi() => {
    'idCustomer': idCustomer,
    'idPaymentFrequency': idPaymentFrequency,
    'idPaymentMethod': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'startDate': startDate?.toServer(),
    'idLoanToRenew': idLoanToRenew,
    'paidDate': paidDate?.toServer(),
    'idOfQuota': idOfQuota,
  };
  
  Map<String, dynamic> toJson() => {
    'idCustomer': idCustomer,
    'idPaymentFrequency': idPaymentFrequency,
    'idPaymentMethod': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'startDate': startDate?.toServer(),
    'idLoanToRenew': idLoanToRenew,
    'paidDate': paidDate?.toServer(),
    'idOfQuota': idOfQuota,

    'customerEntity': customerEntity?.toJson(),
    'paymentFrequencyEntity': paymentFrequencyEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  }; 
}