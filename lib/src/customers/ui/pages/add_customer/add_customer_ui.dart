
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
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
    id = ValidateResult.initialize(label: 'Id', value: customer.id);
    idTypeDocument = ValidateResult.initialize(label: typeDocumentString, value: customer.idTypeDocument);
    idTypeCustomer = ValidateResult.initialize(label: typeCustomerString, value: customer.idTypeCustomer);
    alias = ValidateResult.initialize(label: aliasString, value: customer.alias);
    name = ValidateResult.initialize(label: nameString, value: customer.name);
    lastName = ValidateResult.initialize(label: lastNameString, value: customer.lastName);
    document = ValidateResult.initialize(label: documentString, value: customer.document);
    address = ValidateResult.initialize(label: addressString, value: customer.address);
  }

}