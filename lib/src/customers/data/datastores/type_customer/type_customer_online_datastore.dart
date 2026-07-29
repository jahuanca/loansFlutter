import 'package:loands_flutter/src/customers/data/datastores/type_customer/type_customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class TypeCustomerOnlineDatastore extends TypeCustomerDatastore {
  
  @override
  Future<Result<List<TypeCustomerEntity>>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(url: '/type-customer');
    return executeResponseList<TypeCustomerEntity>(
        response: response, convert: typeCustomerEntityFromJson);
  }
  
}