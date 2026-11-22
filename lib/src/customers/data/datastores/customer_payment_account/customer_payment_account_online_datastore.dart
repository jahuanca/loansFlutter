import 'package:loands_flutter/src/customers/data/datastores/customer_payment_account/customer_payment_account_datastore.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

// Endpoints de loans_node: src/customer/routes/customer_payment_account_routes.js
class CustomerPaymentAccountOnlineDatastore extends CustomerPaymentAccountDatastore {
  static const String _base = '/customer-payment-account';

  @override
  Future<Result<List<CustomerPaymentAccountEntity>>> getByCustomer(int idCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '$_base/customer/$idCustomer');
    return executeResponseList<CustomerPaymentAccountEntity>(
        response: response, convert: customerPaymentAccountEntityFromJson);
  }

  @override
  Future<Result<CustomerPaymentAccountEntity>> create(
      int idCustomer, CustomerPaymentAccountRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.post(
        url: '$_base/create', body: request.toCreateJson(idCustomer));
    return executeResponseObject<CustomerPaymentAccountEntity>(
        response: response, convert: CustomerPaymentAccountEntity.fromJson);
  }

  @override
  Future<Result<CustomerPaymentAccountEntity>> update(
      CustomerPaymentAccountRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.put(
        url: '$_base/update', body: request.toUpdateJson());
    return executeResponseObject<CustomerPaymentAccountEntity>(
        response: response, convert: CustomerPaymentAccountEntity.fromJson);
  }

  @override
  Future<Result<CustomerPaymentAccountEntity>> delete(int id) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.delete(url: '$_base/delete/$id');
    return executeResponseObject<CustomerPaymentAccountEntity>(
        response: response, convert: CustomerPaymentAccountEntity.fromJson);
  }
}
