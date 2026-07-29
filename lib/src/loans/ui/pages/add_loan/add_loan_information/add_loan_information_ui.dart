
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:utils/utils.dart';

class AddLoanInformationUi {

  ValidateResult<DateTime>? startDate;

  ValidateResult<int>?
      id,
      idCustomer,
      idPaymentFrequency,
      idPaymentMethod;

  ValidateResult<double>? 
      percentage,
      amount;

  int? idLoanToRenew;
  CustomerEntity? customerSelected;
  PaymentFrequencyEntity? frequencySelected;
  PaymentMethodEntity? methodSelected;
  LoanEntity? previousLoanSelected;

  ValidateResult? validate() {
    return findErrorInValidations([]);
  }

  double get ganancy {
    if ([amount?.value, percentage?.value].contains(null) ) {
      return defaultDouble;
    }
    return (amount!.value.orZero()) * (percentage!.value.orZero()) / 100;
  }

  ValidateLoanRequest get validateRequest => ValidateLoanRequest(
            idCustomer: idCustomer!.value.orZero(),
            idPaymentFrequency: idPaymentFrequency!.value.orZero(),
            percentage: percentage!.value.orZero(),
            amount: amount!.value.orZero(),
            startDate: startDate!.value.orNow());

  AddLoanRequest get addLoanRequest => AddLoanRequest(
    amount: amount?.value,
    ganancy: ganancy,
    id: id?.value,
    idCustomer: idCustomer?.value,
    idPaymentFrequency: idPaymentFrequency?.value,
    idPaymentMethod: idPaymentMethod?.value,
    customerEntity: customerSelected,
    paymentFrequencyEntity: frequencySelected,
    paymentMethodEntity: methodSelected,
    percentage: percentage?.value,
    startDate: startDate?.value,
    idLoanToRenew: idLoanToRenew,
  );

}