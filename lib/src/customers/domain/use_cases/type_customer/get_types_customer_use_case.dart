
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/type_customer_repository.dart';
import 'package:utils/utils.dart';

class GetTypesCustomerUseCase {
  TypeCustomerRepository repository;

  GetTypesCustomerUseCase(this.repository);

  Future<ResultType<List<TypeCustomerEntity>, ErrorEntity>> execute() async {
    return repository.getAll();
  }
}