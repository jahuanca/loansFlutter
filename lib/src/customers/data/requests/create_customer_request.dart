import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
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
  CustomerPaymentAccountEntity? customerPaymentAccount;

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
    this.customerPaymentAccount,
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
        'customerPaymentAccount': customerPaymentAccount?.toJson(),
      };
    squema.addIf( id != null , 'id', id);
    return squema;
  }

  factory CreateCustomerRequest.fromJson(Map<String, dynamic> json) =>
      CreateCustomerRequest(
        id: json['id'],
        idAssignedRecoveryAgent: json['idAssignedRecoveryAgent'],
        idTypeDocument: json['idTypeDocument'],
        idTypeCustomer: json['idTypeCustomer'],
        alias: json['alias'],
        name: json['name'],
        lastName: json['lastName'],
        phone: json['phone'],
        document: json['document'],
        address: json['address'],
        customerPaymentAccount: json['customerPaymentAccount'] == null
            ? null
            : CustomerPaymentAccountEntity.fromJson(json['customerPaymentAccount']),
      );
}
