import 'dart:convert';

SummaryOfCalendarResponse summaryOfCalendarResponseFromJson(String str) => SummaryOfCalendarResponse.fromJson(json.decode(str));

String summaryOfCalendarResponseToJson(SummaryOfCalendarResponse data) => json.encode(data.toJson());

class SummaryOfCalendarResponse {
    int overduePayments;
    int paymentsOfToday;
    

    SummaryOfCalendarResponse({
        required this.overduePayments,
        required this.paymentsOfToday,
        
    });

    factory SummaryOfCalendarResponse.fromJson(Map<String, dynamic> json) => SummaryOfCalendarResponse(
        overduePayments: json["overdue_payments"],
        paymentsOfToday: json["payments_of_today"],
    );

    Map<String, dynamic> toJson() => {
        "overdue_payments": overduePayments,
        'payments_of_today': paymentsOfToday,        
    };
}