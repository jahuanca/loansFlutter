import 'dart:convert';

SummaryOfDashboardResponse summaryOfDashboardResponseFromJson(String str) => SummaryOfDashboardResponse.fromJson(json.decode(str));

String dashboardSummaryResponseToJson(SummaryOfDashboardResponse data) => json.encode(data.toJson());

class SummaryOfDashboardResponse {
    String loans;
    String amounts;
    String ganancy;
    String renovar;
    double injection;

    SummaryOfDashboardResponse({
        required this.loans,
        required this.amounts,
        required this.ganancy,
        required this.renovar,
        required this.injection,
    });

    factory SummaryOfDashboardResponse.fromJson(Map<String, dynamic> json) => SummaryOfDashboardResponse(
        loans: json["loans"],
        amounts: json["amounts"],
        ganancy: json["ganancy"],
        renovar: json["renovar"],
        injection: (json["injection"] as num).toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "loans": loans,
        "amounts": amounts,
        'ganancy': ganancy,
        'renovar': renovar,
        'injection': injection,
    };
}