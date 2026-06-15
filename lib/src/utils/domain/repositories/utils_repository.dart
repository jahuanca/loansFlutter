
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/type_document_entity.dart';
import 'package:utils/utils.dart';

abstract class UtilsRepository {
  Future<Result<List<TypeDocumentEntity>, ErrorEntity>> getTypesDocument();
  Future<Result<List<PaymentFrequencyEntity>, ErrorEntity>> getPaymentFrecuencies();
  Future<Result<List<PaymentMethodEntity>, ErrorEntity>> getMethodsPayment();
  Future<Result<List<ActivityLogEntity>, ErrorEntity>> getLastsLog();
}