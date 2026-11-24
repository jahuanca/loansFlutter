import 'package:loands_flutter/src/customers/data/requests/customer_address_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_address_repository.dart';
import 'package:utils/utils.dart';

class CreateCustomerAddressUseCase {
  CustomerAddressRepository repository;

  CreateCustomerAddressUseCase({required this.repository});

  Future<Result<CustomerAddressEntity>> execute(
          int idCustomer, CustomerAddressRequest request) =>
      repository.create(idCustomer, request);
}
