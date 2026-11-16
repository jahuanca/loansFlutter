import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanRequest {
  int? id;
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
    this.id,
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
    ValidateResult validateIdCustomer = validateText(
      text: idCustomer, 
      label: customerString
    );
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
        validateText(text: startDate, label: startDateString, rules: {RuleValidator.isRequired: true});
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
    id: json['id'],
    idCustomer: json['idCustomer'],
    idPaymentFrequency: json['idPaymentFrequency'],
    idPaymentMethod: json['idPaymentMethod'],
    percentage: json['percentage'],
    amount: (json['amount'] as num).toDouble(),
    ganancy: (json['ganancy'] as num).toDouble(),
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
    numberOfInstallments: json['numberOfInstallments'],
    daysBetweenInstallments: json['daysBetweenInstallments'],
    customerEntity: json['customerEntity'] == null ? null : CustomerEntity.fromJson(json['customerEntity']),
    paymentMethodEntity: json['paymentMethodEntity'] == null ? null : PaymentMethodEntity.fromJson(json['paymentMethodEntity']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'idCustomer': idCustomer,
    'idPaymentFrequency': idOfSpecialFrequency,
    'idPaymentMethod': idPaymentMethod,
    'percentage': percentage,
    'amount': amount,
    'ganancy': ganancy,
    'startDate': startDate?.toServer(),
    'numberOfInstallments': numberOfInstallments,
    'daysBetweenInstallments': daysBetweenInstallments,
    'customerEntity': customerEntity?.toJson(),
    'paymentMethodEntity': paymentMethodEntity?.toJson(),
  };
}
