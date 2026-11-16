import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:utils/utils.dart';

class CreateCustomerRequest {
  int? id;
  int? idTypeDocument;
  int? idTypeCustomer;
  String? alias;
  String? name;
  String? lastName;
  String? phone;
  String? document;
  String? address;

  CreateCustomerRequest({
    this.id,
    this.idTypeDocument,
    this.idTypeCustomer,
    this.name,
    this.lastName,
    this.phone,
    this.document,
    this.address,
    this.alias,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> squema = {
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
    return squema;
  }

  factory CreateCustomerRequest.fromJson(Map<String, dynamic> json) =>
      CreateCustomerRequest(
        id: json['id'],
        idTypeDocument: json['idTypeDocument'],
        idTypeCustomer: json['idTypeCustomer'],
        alias: json['alias'],
        name: json['name'],
        lastName: json['lastName'],
        phone: json['phone'],
        document: json['document'],
        address: json['address'],
      );
}
