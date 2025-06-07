import 'dart:convert';

DashboardSummaryResponse dashboardSummaryResponseFromJson(String str) => DashboardSummaryResponse.fromJson(json.decode(str));

String dashboardSummaryResponseToJson(DashboardSummaryResponse data) => json.encode(data.toJson());

class DashboardSummaryResponse {
    int customersCount;
    int loansCount;
    double allAmount;
    double allGanancy;
    DateTime dateToSearch;

    DashboardSummaryResponse({
        required this.customersCount,
        required this.loansCount,
        required this.allAmount,
        required this.allGanancy,
        required this.dateToSearch,
    });

    factory DashboardSummaryResponse.fromJson(Map<String, dynamic> json) => DashboardSummaryResponse(
        customersCount: json["customers_count"],
        loansCount: json["loans_count"],
        allAmount: json["all_amount"] == null ? 0 : (json["all_amount"] as num).toDouble(),
        allGanancy: json["all_ganancy"] == null ? 0 : (json["all_ganancy"] as num).toDouble(),
        dateToSearch: DateTime.parse(json['date_to_search']),
    );

    Map<String, dynamic> toJson() => {
        "customers_count": customersCount,
        "loans_count": loansCount,
        "all_amount": allAmount,
        "all_ganancy": allGanancy,
        'date_to_search': dateToSearch,
    };
}