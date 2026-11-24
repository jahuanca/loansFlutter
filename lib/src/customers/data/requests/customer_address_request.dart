import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';

/// Body que acepta el Joi de /customer-address (customer_address_validation.js).
/// Joi rechaza llaves desconocidas, por eso no se usa `entity.toJson()`.
class CustomerAddressRequest {
  final CustomerAddressEntity address;

  CustomerAddressRequest(this.address);

  Map<String, dynamic> _base() => {
        'type': address.type,
        'address': address.address,
        'reference': address.reference,
        'latitude': address.latitude,
        'longitude': address.longitude,
        'image': address.image,
        'isPrimary': address.isPrimary,
      };

  /// POST /customer-address/create
  Map<String, dynamic> toCreateJson(int idCustomer) => {
        ..._base(),
        'idCustomer': idCustomer,
      };

  /// PUT /customer-address/update (idCustomer no se envia: no cambia de cliente)
  Map<String, dynamic> toUpdateJson() => {
        ..._base(),
        'id': address.id,
      };
}
