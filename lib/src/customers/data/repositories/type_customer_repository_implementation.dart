
import 'package:loands_flutter/src/customers/domain/datastores/type_customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/type_customer_repository.dart';
import 'package:utils/utils.dart';

class TypeCustomerRepositoryImplementation extends TypeCustomerRepository {

  TypeCustomerDatastore datastore;

  TypeCustomerRepositoryImplementation({
    required this.datastore
  });

  @override
  Future<ResultType<List<TypeCustomerEntity>, ErrorEntity>> getAll() {
    return datastore.getAll();
  }
}