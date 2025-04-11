import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:utils/utils.dart';

class UtilsOnlineDatastore extends UtilsDatastore {
  @override
  Future<ResultType<List<TypeDocumentEntity>, ErrorEntity>>
      getTypesDocument() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/type-document');
    if (response.isSuccessful) {
      return Success(data: typeDocumentEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: 'Error del servidor',
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<List<PaymentMethodEntity>, ErrorEntity>>
      getMethodsPayment() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-method');
    if (response.isSuccessful) {
      return Success(data: paymentMethodEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: 'Error del servidor',
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<List<PaymentFrequencyEntity>, ErrorEntity>>
      getPaymentFrecuencies() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.get(url: '/utils/payment-frequency');
    if (response.isSuccessful) {
      return Success(data: paymentFrequencyEntityFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: 'Error del servidor',
              errorMessage: response.body));
    }
  }
}
