
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
    id = ValidateResult.toInit(customer.id);
    idTypeDocument = ValidateResult.toInit(customer.idTypeDocument);
    idTypeCustomer = ValidateResult.toInit(customer.idTypeCustomer);
    alias = ValidateResult.toInit(customer.alias);
    name = ValidateResult.toInit(customer.name);
    lastName = ValidateResult.toInit(customer.lastName);
    document = ValidateResult.toInit(customer.document);
    address = ValidateResult.toInit(customer.address);
  }

}