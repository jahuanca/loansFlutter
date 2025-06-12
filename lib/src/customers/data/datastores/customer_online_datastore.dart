import 'dart:convert';

import 'package:loands_flutter/src/customers/data/requests/create_customer_request.dart';
import 'package:loands_flutter/src/customers/domain/datastores/customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

class CustomerOnlineDatastore extends CustomerDatastore {
  @override
  Future<ResultType<CustomerEntity, ErrorEntity>> create(
      CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.post(
        url: '/customer/create', body: request.toJson());
    if (response.isSuccessful) {
      return Success(data: CustomerEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<List<CustomerEntity>, ErrorEntity>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
      url: '/customer',
    );
    if (response.isSuccessful) {
      return Success(data: customerEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<CustomerEntity, ErrorEntity>> update(
      CreateCustomerRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.put(
        url: '/customer/update', body: request.toJson());
    if (response.isSuccessful) {
      return Success(data: CustomerEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}
