


 import 'package:loands_flutter/src/utils/domain/datastore/utils_datastore.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

class UtilsRepositoryImplementation extends UtilsRepository {

  UtilsDatastore datastore;

  UtilsRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<List<TypeDocumentEntity>, ErrorEntity>> getTypesDocument() {
    return datastore.getTypesDocument();
  }

  @override
  Future<ResultType<List<PaymentMethodEntity>, ErrorEntity>> getMethodsPayment() {
    return datastore.getMethodsPayment();
  }

  @override
  Future<ResultType<List<PaymentFrequencyEntity>, ErrorEntity>> getPaymentFrecuencies() {
    return datastore.getPaymentFrecuencies();
  }

  @override
  Future<ResultType<List<ActivityLogEntity>, ErrorEntity>> getLastsLog() {
    return datastore.getLastsLog();
  }
}