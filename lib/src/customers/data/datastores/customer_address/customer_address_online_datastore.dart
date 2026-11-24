import 'dart:io';
import 'package:loands_flutter/src/customers/data/datastores/customer_address/customer_address_datastore.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_address_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

// Endpoints de loans_node: src/customer/routes/customer_address_routes.js
class CustomerAddressOnlineDatastore extends CustomerAddressDatastore {
  static const String _base = '/customer-address';

  @override
  Future<Result<List<CustomerAddressEntity>>> getByCustomer(int idCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '$_base/customer/$idCustomer');
    return executeResponseList<CustomerAddressEntity>(
        response: response, convert: customerAddressEntityFromJson);
  }

  @override
  Future<Result<CustomerAddressEntity>> create(
      int idCustomer, CustomerAddressRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.post(
        url: '$_base/create', body: request.toCreateJson(idCustomer));
    return executeResponseObject<CustomerAddressEntity>(
        response: response, convert: CustomerAddressEntity.fromJson);
  }

  @override
  Future<Result<CustomerAddressEntity>> update(CustomerAddressRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.put(
        url: '$_base/update', body: request.toUpdateJson());
    return executeResponseObject<CustomerAddressEntity>(
        response: response, convert: CustomerAddressEntity.fromJson);
  }

  /// POST /customer-address/upload-image (multipart, campo `image`).
  /// AppHttpManager (paquete utils) solo envia JSON, por eso aqui se arma el
  /// multipart con `http`, copiando lo que hace AppHttpManager: URL base, token y timeout.
  /// Candidato a mover al paquete utils como `AppHttpManager.multipart`.
  @override
  Future<Result<String>> uploadImage(File image) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.sendFile(
        url: '$_base/update', path: image.path);
      return executeResponseObject<String>(
        response: response,
        convert: (json) => json['image'] as String,
      );
    
  }

  

  /// El backend decide la extension por el mimetype, asi que hay que enviarlo bien.
  
}
