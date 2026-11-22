import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:utils/utils.dart';

class CreateCustomerRequest {
  int? id;
  int? idAssignedRecoveryAgent;
  int? idTypeDocument;
  int? idTypeCustomer;
  String? alias;
  String? name;
  String? lastName;
  String? phone;
  String? document;
  String? address;
  List<CustomerPaymentAccountRequest> customerPaymentAccounts;

  CreateCustomerRequest({
    this.id,
    this.idAssignedRecoveryAgent,
    this.idTypeDocument,
    this.idTypeCustomer,
    this.name,
    this.lastName,
    this.phone,
    this.document,
    this.address,
    this.alias,
    this.customerPaymentAccounts = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> squema = {
        'idAssignedRecoveryAgent': idAssignedRecoveryAgent,
        'idTypeDocument': idTypeDocument,
        'idTypeCustomer': idTypeCustomer,
        'alias': alias.isBlank.orFalse() ? null : alias,
        'name': name,
        'lastName': lastName,
        'phone': phone,
        'document': document,
        'address': address,
      };
    squema.addIf( id != null , 'id', id);
    // Solo en create: el Joi de /customer/update no acepta cuentas
    // (en edicion se gestionan con /customer-payment-account).
    squema.addIf(
      id == null && customerPaymentAccounts.isNotEmpty,
      'customerPaymentAccounts',
      customerPaymentAccounts.map((x) => x.toNestedJson()).toList(),
    );
    return squema;
  }
}
