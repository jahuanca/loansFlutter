
import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/domain/repositories/dashboard_repository.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

class PayQuotaUseCase {

  DashboardRepository repository;

  PayQuotaUseCase({
    required this.repository,
  });

  Future<ResultType<QuotaEntity, ErrorEntity>> execute(PayQuotaRequest payQuotaRequest) {
    return repository.payQuota(payQuotaRequest);
  }
}