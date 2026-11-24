import 'dart:io';

import 'package:loands_flutter/src/customers/domain/repositories/customer_address_repository.dart';
import 'package:utils/utils.dart';

class UploadCustomerAddressImageUseCase {
  CustomerAddressRepository repository;

  UploadCustomerAddressImageUseCase({required this.repository});

  /// Devuelve la clave de la foto (p. ej. 'customer_addresses/1732...-uuid.jpg').
  Future<Result<String>> execute(File image) => repository.uploadImage(image);
}
