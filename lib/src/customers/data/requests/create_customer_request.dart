import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:utils/utils.dart';

/// Body de POST /customer/create. Direcciones y cuentas de pago NO van aqui:
/// usan sus propios servicios (/customer-address, /customer-payment-account)
/// y se agregan desde el detalle del cliente.
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

  CreateCustomerRequest({
    this.id,
    this.idAssignedRecoveryAgent,
    this.idTypeDocument,
    this.idTypeCustomer,
    this.name,
    this.lastName,
    this.phone,
    this.document,
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
      };
    squema.addIf( id != null , 'id', id);
    return squema;
  }
}
