
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

abstract class CustomerDatastore {
  Future<ResultType<List<CustomerEntity>, ErrorEntity>> getAll();
  Future<ResultType<CustomerAnalyticsResponse, ErrorEntity>> getAnalytics(int idOfCustomer);
  Future<ResultType<CustomerEntity, ErrorEntity>> create(CreateCustomerRequest request);
  Future<ResultType<CustomerEntity, ErrorEntity>> update(CreateCustomerRequest request);
}