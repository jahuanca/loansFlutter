import 'package:loands_flutter/src/customers/data/datastores/customer_payment_account/customer_payment_account_datastore.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_payment_account_repository.dart';
import 'package:utils/utils.dart';

class CustomerPaymentAccountRepositoryImplementation extends CustomerPaymentAccountRepository {
  CustomerPaymentAccountDatastore datastore;

  CustomerPaymentAccountRepositoryImplementation({required this.datastore});

  @override
  Future<Result<List<CustomerPaymentAccountEntity>>> getByCustomer(int idCustomer) =>
      datastore.getByCustomer(idCustomer);

  @override
  Future<Result<CustomerPaymentAccountEntity>> create(
          int idCustomer, CustomerPaymentAccountRequest request) =>
      datastore.create(idCustomer, request);

  @override
  Future<Result<CustomerPaymentAccountEntity>> update(CustomerPaymentAccountRequest request) =>
      datastore.update(request);

  @override
  Future<Result<CustomerPaymentAccountEntity>> delete(int id) => datastore.delete(id);
}
