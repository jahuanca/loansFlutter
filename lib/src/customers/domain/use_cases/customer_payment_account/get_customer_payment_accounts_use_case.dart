import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_payment_account_repository.dart';
import 'package:utils/utils.dart';

class GetCustomerPaymentAccountsUseCase {
  CustomerPaymentAccountRepository repository;

  GetCustomerPaymentAccountsUseCase({required this.repository});

  Future<Result<List<CustomerPaymentAccountEntity>>> execute(int idCustomer) =>
      repository.getByCustomer(idCustomer);
}
