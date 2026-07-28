
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/data/datastores/renewal/renewal_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class RenewalOnlineDatastore extends RenewalDataStore {

  @override
  Future<Result<PayAndRenewalResponse>> payAndRenewal(PayAndRenewalRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.post(url: '/renewal/pay_and_renewal', body: request.toApi());

    return executeResponseObject<PayAndRenewalResponse>(
        response: response, convert: PayAndRenewalResponse.fromJson);
  }

  @override
  Future<Result<RenewalEntity>> add(AddRenewalRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.post(url: '/renewal/create', body: request.toJson());
    return executeResponseObject<RenewalEntity>(
        response: response, convert: RenewalEntity.fromJson);   
  }

  @override
  Future<Result<GetMetadataRenewalResponse>> getMetadata(int idCustomer) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.get(url: '/renewal/metadata', query: {'id_customer': idCustomer});
    
    return executeResponseObject<GetMetadataRenewalResponse>(
        response: response, convert: GetMetadataRenewalResponse.fromJson);

  }

  @override
  Future<Result<PayAndRenewalResponse>> payAndRenewalSpecial(PayAndRenewalSpecialRequest request) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response =
        await appHttpManager.post(url: '/renewal/pay_and_renewal_special', body: request.toApi());

    return executeResponseObject<PayAndRenewalResponse>(
        response: response, convert: PayAndRenewalResponse.fromJson);
  }
}