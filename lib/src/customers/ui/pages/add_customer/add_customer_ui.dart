
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

class AddCustomerUi {

  ValidateResult<int>? 
      id,
      idTypeDocument,
      idTypeCustomer;
    
  ValidateResult<String>? 
      document,
      name,
      alias,
      lastName,
      address;

  AddCustomerUi({
    this.address,
    this.document,
    this.lastName,
    this.name,
    this.alias,
    this.id,
    this.idTypeCustomer,
    this.idTypeDocument,
  });

  ValidateResult? validate() {
    return findErrorInValidations([address, document, lastName, name, idTypeCustomer, idTypeDocument, alias]);
  }

  CreateCustomerRequest toRequest() {
    return CreateCustomerRequest(
      id: id?.value,
      address: address?.value,
      alias: alias?.value,
      document: document?.value,
      idTypeCustomer: idTypeCustomer?.value,
      idTypeDocument: idTypeDocument?.value,
      lastName: lastName?.value,
      name: name?.value,
    );
  }

  void setValuesOfCustomer(CustomerEntity customer) {
    id = ValidateResult(value: customer.id, hasError: false);
    idTypeDocument = ValidateResult(value: customer.idTypeDocument, hasError: false);
    idTypeCustomer = ValidateResult(value: customer.idTypeCustomer, hasError: false);
    alias = ValidateResult(value: customer.alias, hasError: false);
    name = ValidateResult(value: customer.name, hasError: false);
    lastName = ValidateResult(value: customer.lastName, hasError: false);
    document = ValidateResult(value: customer.document, hasError: false);
    address = ValidateResult(value: customer.address, hasError: false);
  }

}