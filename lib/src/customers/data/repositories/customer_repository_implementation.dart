
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class CustomerRepositoryImplementation extends CustomerRepository {

  CustomerDatastore datastore;

  CustomerRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<Result<CustomerEntity>> create(CreateCustomerRequest request) {
    return datastore.create(request);
  }

  @override
  Future<Result<List<CustomerEntity>>> getAll() {
    return datastore.getAll();
  }
  
  @override
  Future<Result<CustomerEntity>> update(CreateCustomerRequest request) {
    return datastore.update(request);
  }
  
  @override
  Future<Result<CustomerAnalyticsResponse>> getAnalytics(int idOfCustomer) {
    return datastore.getAnalytics(idOfCustomer);
  }
  
  @override
  Future<Result<List<CustomerEntity>>> getWithoutLoan() {
    return datastore.getWithoutLoan();
  }
}