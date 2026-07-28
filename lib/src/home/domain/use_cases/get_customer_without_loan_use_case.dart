
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class GetCustomerWithoutLoanUseCase {

  CustomerRepository repository;

  GetCustomerWithoutLoanUseCase(this.repository);

  Future<Result<List<CustomerEntity>>> execute() async {
    return repository.getWithoutLoan();
  }

}