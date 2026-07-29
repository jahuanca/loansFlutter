import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/data/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:utils/utils.dart';

class UtilsOnlineDatastore extends UtilsDatastore {
  @override
  Future<Result<List<TypeDocumentEntity>>> getTypesDocument() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/type-document');
    return executeResponseList<TypeDocumentEntity>(
        response: response, convert: typeDocumentEntityFromJson);
  }

  @override
  Future<Result<List<PaymentMethodEntity>>> getMethodsPayment() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-method');

    return executeResponseList<PaymentMethodEntity>(
        response: response, convert: paymentMethodEntityFromJson);
  }

  @override
  Future<Result<List<PaymentFrequencyEntity>>> getPaymentFrecuencies() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-frequency');

    return executeResponseList<PaymentFrequencyEntity>(
        response: response, convert: paymentFrequencyEntityFromJson);
  }

  @override
  Future<Result<List<ActivityLogEntity>>> getLastsLog() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/log');

    return executeResponseList<ActivityLogEntity>(
        response: response, convert: activityLogEntityFromJson);
  }
}
