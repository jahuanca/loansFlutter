import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanRequest {
  int? idCustomer;
  int? idPaymentFrequency;
  int? idPaymentMethod;
  double? percentage;
  double? amount;
  double? ganancy;
  DateTime? startDate;
  int? numberOfInstallments;
  int? daysBetweenInstallments;

  CustomerEntity? customerEntity;
  PaymentMethodEntity? paymentMethodEntity;

  AddSpecialLoanRequest({
    this.idCustomer,
    this.idPaymentFrequency,
    this.idPaymentMethod,
    this.percentage,
    this.amount,
    this.ganancy,
    this.startDate,
    this.customerEntity,
    this.paymentMethodEntity,
    this.daysBetweenInstallments,
    this.numberOfInstallments,
  });

  String? get validate {
    ValidateResult validateIdCustomer =
        validateText(text: idCustomer, label: customerString);
    ValidateResult validateIdPaymentFrequency =
        validateText(text: idPaymentFrequency, label: 'Frecuencia de pago');
    ValidateResult validateIdPaymentMethod =
        validateText(text: idPaymentMethod, label: paymentMethodString);
    ValidateResult validatePercentage =
        validateText(
          text: percentage.orZero(), 
          label: percentageString,
          rules: {
            RuleValidator.minValue: 5,
            RuleValidator.maxValue: 50,
          }
        );
    ValidateResult validateAmount = validateText(text: amount, label: amountString);
    ValidateResult validateGanancy =
        validateText(text: ganancy, label: ganancyString);
    ValidateResult validateStartDate =
        validateText(text: startDate, label: startDateString);
    ValidateResult validateDaysBetweenInstallments =
        validateText(text: daysBetweenInstallments, label: 'Dias entre cuotas');
    ValidateResult validateNumberOfInstallments =
        validateText(text: numberOfInstallments, label: 'Dias entre cuotas');

    ValidateResult? error = findErrorInValidations([
      validateIdCustomer,
      validateIdPaymentFrequency,
      validateIdPaymentMethod,
      validatePercentage,
      validateAmount,
      validateGanancy,
      validateStartDate,
      validateDaysBetweenInstallments,
      validateNumberOfInstallments,
    ]);

    return error?.error;
  }

  factory AddSpecialLoanRequest.fromJson(Map<String, dynamic> json) => AddSpecialLoanRequest(
    idCustomer: json['id_customer'],
    idPaymentFrequency: json['id_payment_frequency'],
    idPaymentMethod: json['id_payment_method'],
    percentage: json['percentage'],
    amount: (json['amount'] as num).toDouble(),
    ganancy: (json['ganancy'] as num).toDouble(),
    startDate: json['start_date'] == null ? null : DateTime.parse(json['start_date']),
    numberOfInstallments: json['number_of_installments'],
    daysBetweenInstallments: json['days_between_installments'],
    customerEntity: json['customerEntity'] == null ? null : CustomerEntity.fromJson(json['customerEntity']),
    paymentMethodEntity: json['paymentMethodEntity'] == null ? null : PaymentMethodEntity.fromJson(json['paymentMethodEntity']),
  );

  Map<String, dynamic> toJson() => {
    'id_customer': idCustomer,
    'id_payment_frequency': idOfSpecialFrequency,
    'id_payment_method': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'start_date': startDate?.toIso8601String(),
    'number_of_installments': numberOfInstallments,
    'days_between_installments': daysBetweenInstallments,
    'customerEntity': customerEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  };
}
