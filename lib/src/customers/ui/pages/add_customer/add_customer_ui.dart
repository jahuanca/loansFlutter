
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddCustomerUi {

  ValidateResult<int>? 
      id,
      idTypeDocument,
      idAssignedRecoveryAgent,
      idTypeCustomer,
      idPaymentProvider;
    
  ValidateResult<String>? 
      document,
      name,
      alias,
      lastName,
      phone,
      address,
      accountNumber,
      cci,
      paymentPhone,
      holderName;

  AddCustomerUi({
    this.address,
    this.document,
    this.lastName,
    this.name,
    this.alias,
    this.id,
    this.idAssignedRecoveryAgent,
    this.idTypeCustomer,
    this.idTypeDocument,
    this.idPaymentProvider,
    this.accountNumber,
    this.cci,
    this.paymentPhone,
    this.holderName,
  });

  ValidateResult? validate() {
    return findErrorInValidations([address, document, lastName, name, phone, idTypeCustomer, idTypeDocument, alias, idPaymentProvider, accountNumber, cci, paymentPhone, holderName]);
  }

  CreateCustomerRequest toRequest() {
    return CreateCustomerRequest(
      id: id?.value,
      idAssignedRecoveryAgent: idAssignedRecoveryAgent?.value,
      address: address?.value,
      alias: alias?.value,
      document: document?.value,
      idTypeCustomer: idTypeCustomer?.value,
      idTypeDocument: idTypeDocument?.value,
      lastName: lastName?.value,
      phone: phone?.value,
      name: name?.value,
      customerPaymentAccount: _toCustomerPaymentAccount(),
    );
  }

  CustomerPaymentAccountEntity? _toCustomerPaymentAccount() {
    if (idPaymentProvider?.value == null) return null;
    String? orNull(String? value) =>
        (value == null || value.trim().isEmpty) ? null : value.trim();
    return CustomerPaymentAccountEntity(
      id: _idCustomerPaymentAccount,
      idCustomer: id?.value,
      idPaymentProvider: idPaymentProvider!.value!,
      accountNumber: orNull(accountNumber?.value),
      cci: orNull(cci?.value),
      phone: orNull(paymentPhone?.value),
      holderName: orNull(holderName?.value),
    );
  }

  int? _idCustomerPaymentAccount;

  void setValuesOfCustomer(CustomerEntity customer) {
    id = ValidateResult.initialize(label: 'Id', value: customer.id);
    idTypeDocument = ValidateResult.initialize(label: typeDocumentString, value: customer.idTypeDocument);
    idAssignedRecoveryAgent = ValidateResult.initialize(label: assignedRecoveryAgentString, value: customer.idAssignedRecoveryAgent);
    idTypeCustomer = ValidateResult.initialize(label: typeCustomerString, value: customer.idTypeCustomer);
    alias = ValidateResult.initialize(label: aliasString, value: customer.alias);
    name = ValidateResult.initialize(label: nameString, value: customer.name);
    lastName = ValidateResult.initialize(label: lastNameString, value: customer.lastName);
    phone = ValidateResult.initialize(label: phoneString, value: customer.phone);
    document = ValidateResult.initialize(label: documentString, value: customer.document);
    address = ValidateResult.initialize(label: addressString, value: customer.address);

    CustomerPaymentAccountEntity? paymentAccount = customer.customerPaymentAccountEntity;
    if (paymentAccount != null) {
      _idCustomerPaymentAccount = paymentAccount.id;
      idPaymentProvider = ValidateResult.initialize(label: paymentProviderString, value: paymentAccount.idPaymentProvider);
      accountNumber = ValidateResult.initialize(label: accountNumberString, value: paymentAccount.accountNumber);
      cci = ValidateResult.initialize(label: cciString, value: paymentAccount.cci);
      paymentPhone = ValidateResult.initialize(label: paymentPhoneString, value: paymentAccount.phone);
      holderName = ValidateResult.initialize(label: holderNameString, value: paymentAccount.holderName);
    }
  }

}