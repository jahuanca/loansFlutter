import 'package:loands_flutter/src/customers/domain/datastores/type_customer_datastore.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:utils/utils.dart';

class TypeCustomerOnlineDatastore extends TypeCustomerDatastore {
  
  
  @override
  Future<Result<List<TypeCustomerEntity>, ErrorEntity>> getAll() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(url: '/type-customer');
    if (response.isSuccessful) {
      return Success( typeCustomerEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
  
}