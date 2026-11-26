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

  /// Solo revisa los campos de la categoria elegida (los demas estan ocultos).
  ValidateResult? validate({required bool isBank, required bool isWallet}) {
    return findErrorInValidations([
      idPaymentProvider,
      if (isBank) ...[accountNumber, cci],
      if (isWallet) paymentPhone,
      holderName,
      observation,
    ]);
  }

  /// Los campos que no son de la categoria se mandan en null (el backend hace
  /// lo mismo en normalizeAccountByCategory).
  CustomerPaymentAccountEntity toEntity({required bool isBank, required bool isWallet}) {
    String? orNull(String? value) =>
        (value == null || value.trim().isEmpty) ? null : value.trim();
    return CustomerPaymentAccountEntity(
      id: _id,
      idCustomer: _idCustomer,
      idPaymentProvider: idPaymentProvider!.value!,
      accountNumber: isBank ? orNull(accountNumber?.value) : null,
      cci: isBank ? orNull(cci?.value) : null,
      phone: isWallet ? orNull(paymentPhone?.value) : null,
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
