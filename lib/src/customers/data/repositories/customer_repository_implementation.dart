
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class CustomerRepositoryImplementation extends CustomerRepository {

  CustomerDatastore datastore;

  CustomerRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<CustomerEntity, ErrorEntity>> create(CreateCustomerRequest request) {
    return datastore.create(request);
  }

  @override
  Future<ResultType<List<CustomerEntity>, ErrorEntity>> getAll() {
    return datastore.getAll();
  }
  
  @override
  Future<ResultType<CustomerEntity, ErrorEntity>> update(CreateCustomerRequest request) {
    return datastore.update(request);
  }
}