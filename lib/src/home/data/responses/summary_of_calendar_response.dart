import 'dart:convert';

String summaryOfCalendarResponseToJson(SummaryOfCalendarResponse data) => json.encode(data.toJson());

class SummaryOfCalendarResponse {
    int overduePayments;
    int paymentsOfToday;
    

    SummaryOfCalendarResponse({
        required this.overduePayments,
        required this.paymentsOfToday,
        
    });

    factory SummaryOfCalendarResponse.fromJson(Map<String, dynamic> json) => SummaryOfCalendarResponse(
        overduePayments: json["overduePayments"],
        paymentsOfToday: json["paymentsOfToday"],
    );

    Map<String, dynamic> toJson() => {
        "overduePayments": overduePayments,
        'paymentsOfToday': paymentsOfToday,        
    };
}