
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/requests/update_customer_manage_data_request.dart';
import 'package:loands_flutter/src/customers/data/requests/update_customer_personal_data_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class AddCustomerUi {

  ValidateResult<int>?
      id,
      idTypeDocument,
      idAssignedRecoveryAgent,
      idTypeCustomer;

  ValidateResult<String>?
      document,
      name,
      alias,
      lastName,
      phone;

  AddCustomerUi({
    this.document,
    this.lastName,
    this.name,
    this.alias,
    this.id,
    this.idAssignedRecoveryAgent,
    this.idTypeCustomer,
    this.idTypeDocument,
  });

  ValidateResult? validate() {
    return findErrorInValidations([document, lastName, name, phone, idTypeCustomer, idTypeDocument, alias]);
  }

  CreateCustomerRequest toRequest() {
    return CreateCustomerRequest(
      id: id?.value,
      idAssignedRecoveryAgent: idAssignedRecoveryAgent?.value,
      alias: alias?.value,
      document: document?.value,
      idTypeCustomer: idTypeCustomer?.value,
      idTypeDocument: idTypeDocument?.value,
      lastName: lastName?.value,
      phone: phone?.value,
      name: name?.value,
    );
  }

  /// Solo para edicion: `id` viene cargado por setValuesOfCustomer.
  UpdateCustomerPersonalDataRequest toPersonalDataRequest() {
    return UpdateCustomerPersonalDataRequest(
      id: id!.value!,
      idTypeDocument: idTypeDocument?.value,
      document: document?.value,
      alias: alias?.value,
      name: name?.value,
      lastName: lastName?.value,
      phone: phone?.value,
    );
  }

  /// Solo para edicion: `id` viene cargado por setValuesOfCustomer.
  UpdateCustomerManageDataRequest toManageDataRequest() {
    return UpdateCustomerManageDataRequest(
      id: id!.value!,
      idTypeCustomer: idTypeCustomer?.value,
      idAssignedRecoveryAgent: idAssignedRecoveryAgent?.value,
    );
  }

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
  }

}
