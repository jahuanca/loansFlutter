import 'package:loands_flutter/src/customers/data/requests/customer_payment_account_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_payment_account_repository.dart';
import 'package:utils/utils.dart';

class UpdateCustomerPaymentAccountUseCase {
  CustomerPaymentAccountRepository repository;

  UpdateCustomerPaymentAccountUseCase({required this.repository});

  Future<Result<CustomerPaymentAccountEntity>> execute(CustomerPaymentAccountRequest request) =>
      repository.update(request);
}
