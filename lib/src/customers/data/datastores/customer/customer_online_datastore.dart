import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/data/datastores/customer/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class CustomerOnlineDatastore extends CustomerDatastore {
  @override
  Future<Result<CustomerEntity>> create(CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.post(
        url: '/customer/create', body: request.toJson());
    return executeResponseObject<CustomerEntity>(
        response: response, convert: CustomerEntity.fromJson);
  }

  @override
  Future<Result<List<CustomerEntity>>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/customer',
    );
    return executeResponseList<List<CustomerEntity>>(
        response: response, convert: customerEntityFromJson);
  }

  @override
  Future<Result<CustomerEntity>> update(CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.put(
        url: '/customer/update', body: request.toJson());
    return executeResponseObject(
        response: response, convert: CustomerEntity.fromJson);
  }

  @override
  Future<Result<CustomerAnalyticsResponse>> getAnalytics(
      int idOfCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/customer/analytics', query: {
      'id_customer': idOfCustomer,
    });

    return executeResponseObject<CustomerAnalyticsResponse>(
        response: response, convert: CustomerAnalyticsResponse.fromJson);
  }

  @override
  Future<Result<List<CustomerEntity>>> getWithoutLoan() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/utils/customer-without-loan');
    return executeResponseList(
        response: response, convert: customerEntityFromJson);
  }
}
