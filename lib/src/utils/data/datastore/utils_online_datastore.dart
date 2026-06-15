import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:utils/utils.dart';

class UtilsOnlineDatastore extends UtilsDatastore {

  @override
  Future<Result<List<TypeDocumentEntity>, ErrorEntity>>
      getTypesDocument() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/type-document');
    if (response.isSuccessful) {
      return Success( typeDocumentEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<List<PaymentMethodEntity>, ErrorEntity>>
      getMethodsPayment() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-method');
    if (response.isSuccessful) {
      return Success( paymentMethodEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<List<PaymentFrequencyEntity>, ErrorEntity>>
      getPaymentFrecuencies() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-frequency');
    if (response.isSuccessful) {
      return Success( paymentFrequencyEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

  @override
  Future<Result<List<ActivityLogEntity>, ErrorEntity>> getLastsLog() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/log');
    if (response.isSuccessful) {
      return Success( activityLogEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }
}
