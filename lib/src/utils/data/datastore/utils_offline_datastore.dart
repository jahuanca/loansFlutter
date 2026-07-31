
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
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
  Future<Result<List<PaymentMethodEntity>>> getMethodsPayment() async {
    final box = await Hive.openBox<PaymentMethodEntity>(HiveDbAdapters.paymentMethod.source);
    List<PaymentMethodEntity> data = box.values.toList();
    await box.close();
    return Result.success(data);
  }

  @override
  Future<Result<List<PaymentFrequencyEntity>>> getPaymentFrecuencies() async {
    final box = await Hive.openBox<PaymentFrequencyEntity>(HiveDbAdapters.paymentFrequency.source);
    List<PaymentFrequencyEntity> data = box.values.toList();
    await box.close();
    return Result.success(data);
  }

  @override
  Future<Result<List<TypeDocumentEntity>>> getTypesDocument() {
    // TODO: implement getTypesDocument
    throw UnimplementedError();
  }

}