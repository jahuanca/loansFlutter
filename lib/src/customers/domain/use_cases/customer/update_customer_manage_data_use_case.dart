import 'package:loands_flutter/src/customers/data/requests/update_customer_manage_data_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_repository.dart';
import 'package:utils/utils.dart';

class UpdateCustomerManageDataUseCase {
  CustomerRepository repository;

  UpdateCustomerManageDataUseCase({
    required this.repository,
  });

  Future<Result<CustomerEntity>> execute(UpdateCustomerManageDataRequest request) {
    return repository.updateManageData(request);
  }
}
