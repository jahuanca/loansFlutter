import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:utils/utils.dart';

abstract class CustomerPaymentAccountRepository {
  Future<Result<List<CustomerPaymentAccountEntity>>> getByCustomer(int idCustomer);
  Future<Result<CustomerPaymentAccountEntity>> create(int idCustomer, CustomerPaymentAccountRequest request);
  Future<Result<CustomerPaymentAccountEntity>> update(CustomerPaymentAccountRequest request);
  Future<Result<CustomerPaymentAccountEntity>> delete(int id);
}
