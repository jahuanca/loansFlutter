
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class GetCustomerAnalyticsUseCase {

  CustomerRepository repository;

  GetCustomerAnalyticsUseCase(this.repository);

  Future<ResultType<CustomerAnalyticsResponse, ErrorEntity>> execute(int idOfCustomer) {
    return repository.getAnalytics(idOfCustomer);
  }

}