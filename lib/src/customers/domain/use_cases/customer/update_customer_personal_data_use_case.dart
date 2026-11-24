import 'package:loands_flutter/src/customers/data/requests/update_customer_personal_data_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class UpdateCustomerPersonalDataUseCase {
  CustomerRepository repository;

  UpdateCustomerPersonalDataUseCase({
    required this.repository,
  });

  Future<Result<CustomerEntity>> execute(UpdateCustomerPersonalDataRequest request) {
    return repository.updatePersonalData(request);
  }
}
