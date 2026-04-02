
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:utils/utils.dart';

abstract class TypeCustomerRepository {

  Future<ResultType<List<TypeCustomerEntity>, ErrorEntity>> getAll();

}