import 'dart:io';

import 'package:loands_flutter/src/customers/data/requests/customer_address_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:utils/utils.dart';

abstract class CustomerAddressDatastore {
  Future<Result<List<CustomerAddressEntity>>> getByCustomer(int idCustomer);
  Future<Result<CustomerAddressEntity>> create(int idCustomer, CustomerAddressRequest request);
  Future<Result<CustomerAddressEntity>> update(CustomerAddressRequest request);
  /// Sube la foto y devuelve la clave que luego va en `image`.
  Future<Result<String>> uploadImage(File image);
}
