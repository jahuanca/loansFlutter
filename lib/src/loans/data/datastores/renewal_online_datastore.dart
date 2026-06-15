
import 'dart:convert';

import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/datastores/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:utils/utils.dart';

class RenewalOnlineDatastore extends RenewalDataStore {

  @override
  Future<Result<PayAndRenewalResponse, ErrorEntity>> payAndRenewal(PayAndRenewalRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.post(url: '/renewal/pay_and_renewal', body: request.toApi());
    if (response.isSuccessful) {
      return Success( PayAndRenewalResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<RenewalEntity, ErrorEntity>> add(AddRenewalRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.post(url: '/renewal/create', body: request.toJson());
    if (response.isSuccessful) {
      return Success( RenewalEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }   
  }

  @override
  Future<Result<GetMetadataRenewalResponse, ErrorEntity>> getMetadata(int idCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.get(url: '/renewal/metadata', query: {'id_customer': idCustomer});
    if (response.isSuccessful) {
      return Success( GetMetadataRenewalResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<PayAndRenewalResponse, ErrorEntity>> payAndRenewalSpecial(PayAndRenewalSpecialRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.post(url: '/renewal/pay_and_renewal_special', body: request.toApi());
    if (response.isSuccessful) {
      return Success( PayAndRenewalResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}