import 'dart:convert';

DashboardSummaryResponse dashboardSummaryResponseFromJson(String str) => DashboardSummaryResponse.fromJson(json.decode(str));

String dashboardSummaryResponseToJson(DashboardSummaryResponse data) => json.encode(data.toJson());

class DashboardSummaryResponse {
    int customersCount;
    DateTime dateToSearch;
    Map<String, dynamic> loansInfo;
    Map<String, dynamic> amountsInfo;
    Map<String, dynamic> ganancyInfo;

    DashboardSummaryResponse({
        required this.customersCount,
        required this.dateToSearch,
        required this.loansInfo,
        required this.amountsInfo,
        required this.ganancyInfo,
    });

    factory DashboardSummaryResponse.fromJson(Map<String, dynamic> json) => DashboardSummaryResponse(
        customersCount: json["customers_count"],
        loansInfo: json["loans_info"],
        amountsInfo: json["amounts_info"],
        ganancyInfo: json["ganancy_info"],
        dateToSearch: DateTime.parse(json['date_to_search']),
    );

    Map<String, dynamic> toJson() => {
        "customers_count": customersCount,
        "loans_info": loansInfo,
        "amounts_info": amountsInfo,
        'ganancy_info': ganancyInfo,
        'date_to_search': dateToSearch,
    };
}