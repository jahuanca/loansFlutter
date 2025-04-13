import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

abstract class QuotaRepository {
  Future<ResultType<List<QuotaEntity>,ErrorEntity>> getAll(Map<String, dynamic> query);
}