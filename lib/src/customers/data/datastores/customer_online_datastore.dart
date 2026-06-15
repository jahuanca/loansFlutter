import 'dart:convert';

import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

class CustomerOnlineDatastore extends CustomerDatastore {

  @override
  Future<Result<CustomerEntity, ErrorEntity>> create(
      CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.post(
        url: '/customer/create', body: request.toJson());
    if (response.isSuccessful) {
      return Success( CustomerEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<List<CustomerEntity>, ErrorEntity>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
      url: '/customer',
    );
    if (response.isSuccessful) {
      return Success( customerEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<CustomerEntity, ErrorEntity>> update(
      CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.put(
        url: '/customer/update', body: request.toJson());
    if (response.isSuccessful) {
      return Success( CustomerEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
  
  @override
  Future<Result<CustomerAnalyticsResponse, ErrorEntity>> getAnalytics(int idOfCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
      url: '/customer/analytics', query: {
        'id_customer': idOfCustomer,
      }
    );
    if (response.isSuccessful) {
      return Success( CustomerAnalyticsResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}
