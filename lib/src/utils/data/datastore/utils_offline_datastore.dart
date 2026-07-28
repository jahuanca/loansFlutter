
import 'package:loands_flutter/src/utils/data/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:utils/utils.dart';

class UtilsOfflineDatastore extends UtilsDatastore  {
  @override
  Future<Result<List<ActivityLogEntity>>> getLastsLog() {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<PaymentMethodEntity>>> getMethodsPayment() {
    // TODO: implement getMethodsPayment
    throw UnimplementedError();
  }

  @override
  Future<Result<List<PaymentFrequencyEntity>>> getPaymentFrecuencies() {
    // TODO: implement getPaymentFrecuencies
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TypeDocumentEntity>>> getTypesDocument() {
    // TODO: implement getTypesDocument
    throw UnimplementedError();
  }

}