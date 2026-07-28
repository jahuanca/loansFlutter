import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
part 'summary_of_dashboard_response.g.dart';


String dashboardSummaryResponseToJson(SummaryOfDashboardResponse data) => json.encode(data.toJson());

@HiveType(typeId: summaryOfDashboardIdAdapter)
class SummaryOfDashboardResponse extends HiveObject{

    @HiveField(0)
    String loans;
    @HiveField(1)
    String amounts;
    @HiveField(2)
    String ganancy;
    @HiveField(3)
    String renovar;
    @HiveField(4)
    double injection;
    @HiveField(5)
    int cesaron;

    SummaryOfDashboardResponse({
        required this.loans,
        required this.amounts,
        required this.ganancy,
        required this.renovar,
        required this.injection,
        required this.cesaron,
    });

    factory SummaryOfDashboardResponse.fromJson(Map<String, dynamic> json) => SummaryOfDashboardResponse(
        loans: json["loans"],
        amounts: json["amounts"],
        ganancy: json["ganancy"],
        renovar: json["renovar"],
        injection: (json["injection"] as num).toDouble(),
        cesaron: json['cesaron'],
    );

    Map<String, dynamic> toJson() => {
        "loans": loans,
        "amounts": amounts,
        'ganancy': ganancy,
        'renovar': renovar,
        'injection': injection,
        'cesaron': cesaron,
    };
}