import 'dart:convert';

SummaryOfDashboardResponse summaryOfDashboardResponseFromJson(String str) => SummaryOfDashboardResponse.fromJson(json.decode(str));

String dashboardSummaryResponseToJson(SummaryOfDashboardResponse data) => json.encode(data.toJson());

class SummaryOfDashboardResponse {
    String loans;
    String amounts;
    String ganancy;
    String renovar;

    SummaryOfDashboardResponse({
        required this.loans,
        required this.amounts,
        required this.ganancy,
        required this.renovar,
    });

    factory SummaryOfDashboardResponse.fromJson(Map<String, dynamic> json) => SummaryOfDashboardResponse(
        loans: json["loans"],
        amounts: json["amounts"],
        ganancy: json["ganancy"],
        renovar: json["renovar"],
    );

    Map<String, dynamic> toJson() => {
        "loans": loans,
        "amounts": amounts,
        'ganancy': ganancy,
        'renovar': renovar,
    };
}