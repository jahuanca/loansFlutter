import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class CreateCustomerUseCase {
  CustomerRepository repository;

  CreateCustomerUseCase({
    required this.repository,
  });

  Future<ResultType<CustomerEntity, ErrorEntity>> execute(
      CreateCustomerRequest request) {
    return repository.create(request);
  }
}
