import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_address_repository.dart';
import 'package:utils/utils.dart';

class GetCustomerAddressesUseCase {
  CustomerAddressRepository repository;

  GetCustomerAddressesUseCase({required this.repository});

  Future<Result<List<CustomerAddressEntity>>> execute(int idCustomer) =>
      repository.getByCustomer(idCustomer);
}
