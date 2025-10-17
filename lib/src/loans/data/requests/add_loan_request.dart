
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';

class AddLoanRequest {

  int? id;
  int? idCustomer;
  int? idPaymentFrequency;
  int? idPaymentMethod;
  double? percentage;
  double? amount;
  double? ganancy;
  DateTime? startDate;

  CustomerEntity? customerEntity;
  PaymentMethodEntity? paymentMethodEntity;
  PaymentFrequencyEntity? paymentFrequencyEntity;

  AddLoanRequest({
    this.id,
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
  });

  factory AddLoanRequest.fromLoanEntity(LoanEntity loan) => 
    AddLoanRequest(
      id: loan.id,
      idCustomer: loan.idCustomer,
      idPaymentFrequency: loan.idPaymentFrequency,
      percentage: loan.percentage,
      amount: loan.amount,
      ganancy: loan.ganancy,
      startDate: loan.startDate,

      customerEntity: loan.customerEntity,
      paymentFrequencyEntity: loan.paymentFrequencyEntity,
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_customer': idCustomer,
    'id_payment_frequency': idPaymentFrequency,
    'id_payment_method': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'start_date': startDate?.toIso8601String(),

    'customerEntity': customerEntity?.toJson(),
    'paymentFrequencyEntity': paymentFrequencyEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  }; 
}