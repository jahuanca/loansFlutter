import 'dart:io';

import 'package:loands_flutter/src/customers/data/datastores/customer_address/customer_address_datastore.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_address_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/repositories/customer_address_repository.dart';
import 'package:utils/utils.dart';

class CustomerAddressRepositoryImplementation extends CustomerAddressRepository {
  CustomerAddressDatastore datastore;

  CustomerAddressRepositoryImplementation({required this.datastore});

  @override
  Future<Result<List<CustomerAddressEntity>>> getByCustomer(int idCustomer) =>
      datastore.getByCustomer(idCustomer);

  @override
  Future<Result<CustomerAddressEntity>> create(int idCustomer, CustomerAddressRequest request) =>
      datastore.create(idCustomer, request);

  @override
  Future<Result<CustomerAddressEntity>> update(CustomerAddressRequest request) =>
      datastore.update(request);

  @override
  Future<Result<String>> uploadImage(File image) => datastore.uploadImage(image);
}
