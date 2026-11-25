import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:utils/utils.dart';

/// Body de POST /customer/create. Las cuentas de pago NO van aqui:
/// usan su propio servicio (/customer-payment-account).
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
    return squema;
  }
}
