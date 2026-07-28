
import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

abstract class CustomerDatastore {
  Future<Result<List<CustomerEntity>>> getAll();
  Future<Result<List<CustomerEntity>>> getWithoutLoan();
  Future<Result<CustomerAnalyticsResponse>> getAnalytics(int idOfCustomer);
  Future<Result<CustomerEntity>> create(CreateCustomerRequest request);
  Future<Result<CustomerEntity>> update(CreateCustomerRequest request);
}