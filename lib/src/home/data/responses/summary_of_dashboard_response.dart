import 'dart:convert';

SummaryOfDashboardResponse summaryOfDashboardResponseFromJson(String str) => SummaryOfDashboardResponse.fromJson(json.decode(str));

String dashboardSummaryResponseToJson(SummaryOfDashboardResponse data) => json.encode(data.toJson());

class SummaryOfDashboardResponse {
    Map<String, dynamic> loansInfo;
    Map<String, dynamic> amountsInfo;
    Map<String, dynamic> ganancyInfo;

    SummaryOfDashboardResponse({
        required this.loansInfo,
        required this.amountsInfo,
        required this.ganancyInfo,
    });

    factory SummaryOfDashboardResponse.fromJson(Map<String, dynamic> json) => SummaryOfDashboardResponse(
        loansInfo: json["loans_info"],
        amountsInfo: json["amounts_info"],
        ganancyInfo: json["ganancy_info"],
    );

    Map<String, dynamic> toJson() => {
        "loans_info": loansInfo,
        "amounts_info": amountsInfo,
        'ganancy_info': ganancyInfo,
    };
}