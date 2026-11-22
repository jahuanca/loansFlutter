import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_payment_account_repository.dart';
import 'package:utils/utils.dart';

class DeleteCustomerPaymentAccountUseCase {
  CustomerPaymentAccountRepository repository;

  DeleteCustomerPaymentAccountUseCase({required this.repository});

  Future<Result<CustomerPaymentAccountEntity>> execute(int id) => repository.delete(id);
}
