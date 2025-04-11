
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class GetCustomersUseCase {

  CustomerRepository repository;

  GetCustomersUseCase({
    required this.repository,
  });

  Future<ResultType<List<CustomerEntity>, ErrorEntity>> execute(){
    return repository.getAll();
  }

}