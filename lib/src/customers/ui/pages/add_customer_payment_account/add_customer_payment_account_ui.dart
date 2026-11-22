import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

/// Estado del formulario de cuenta de pago (antes vivia dentro de AddCustomerUi).
class AddCustomerPaymentAccountUi {
  ValidateResult<int>? idPaymentProvider;

  ValidateResult<String>? accountNumber, cci, paymentPhone, holderName, observation;

  bool isDefault = false;

  int? _id;
  int? _idCustomer;

  ValidateResult? validate() {
    return findErrorInValidations(
        [idPaymentProvider, accountNumber, cci, paymentPhone, holderName, observation]);
  }

  CustomerPaymentAccountEntity toEntity() {
    String? orNull(String? value) =>
        (value == null || value.trim().isEmpty) ? null : value.trim();
    return CustomerPaymentAccountEntity(
      id: _id,
      idCustomer: _idCustomer,
      idPaymentProvider: idPaymentProvider!.value!,
      accountNumber: orNull(accountNumber?.value),
      cci: orNull(cci?.value),
      phone: orNull(paymentPhone?.value),
      holderName: orNull(holderName?.value),
      observation: orNull(observation?.value),
      isDefault: isDefault,
    );
  }

  void setValuesOfAccount(CustomerPaymentAccountEntity account) {
    _id = account.id;
    _idCustomer = account.idCustomer;
    isDefault = account.isDefault;
    idPaymentProvider = ValidateResult.initialize(label: paymentProviderString, value: account.idPaymentProvider);
    accountNumber = ValidateResult.initialize(label: accountNumberString, value: account.accountNumber);
    cci = ValidateResult.initialize(label: cciString, value: account.cci);
    paymentPhone = ValidateResult.initialize(label: paymentPhoneString, value: account.phone);
    holderName = ValidateResult.initialize(label: holderNameString, value: account.holderName);
    observation = ValidateResult.initialize(label: observationString, value: account.observation);
  }
}
