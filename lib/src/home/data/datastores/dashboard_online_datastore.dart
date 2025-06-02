import 'dart:convert';

import 'package:loands_flutter/src/home/data/request/pay_quota_request.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_summary_response.dart';
import 'package:loands_flutter/src/home/domain/datastores/dashboard_datastore.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:utils/utils.dart';

class DashboardOnlineDatastore extends DashboardDatastore {

  @override
  Future<ResultType<DashboardSummaryResponse, ErrorEntity>> getSummary() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
      url: '/utils/summary',
    );
    if (response.isSuccessful) {
      return Success(data: dashboardSummaryResponseFromJson(response.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: '',
              errorMessage: response.body));
    }
  }

  @override
  Future<ResultType<List<DashboardQuotaResponse>, ErrorEntity>> getQuotasByDate(
      DateTime date) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
        url: '/quota/byDate',
        query: {
          'date': /*dateTime.format(formatDate: 'yyyy-MM-dd')*/ '2025-05-09'
        });
    if (response.isSuccessful) {
      return Success(data: dashboardQuotasResponseFromJson(response.body));
    }
    return Error(
        error: ErrorEntity(
            statusCode: response.statusCode,
            title: '',
            errorMessage: response.body));
  }

  @override
  Future<ResultType<QuotaEntity, ErrorEntity>> payQuota(
      PayQuotaRequest payQuotaRequest) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response =
        await appHttpManager.post(url: '/quota/pay', body: payQuotaRequest.toJson());
    if (response.isSuccessful) {
      return Success(data: QuotaEntity.fromJson(jsonDecode(response.body)));
    }
    return Error(
        error: ErrorEntity(
            statusCode: response.statusCode,
            title: '',
            errorMessage: response.body));
  }
}
