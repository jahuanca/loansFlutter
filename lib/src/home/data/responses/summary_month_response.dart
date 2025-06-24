import 'dart:convert';

List<SummaryMonthResponse> summaryMonthFromJson(String str) =>
    List<SummaryMonthResponse>.from(
        json.decode(str).map((x) => SummaryMonthResponse.fromJson(x)));

class SummaryMonthResponse {
  double ganancy;
  int idStateLoan;
  String month;
  String year;

  SummaryMonthResponse({
    required this.ganancy,
    required this.idStateLoan,
    required this.month,
    required this.year,
  });

  DateTime get time => DateTime(int.parse(year), int.parse(month));

  factory SummaryMonthResponse.fromJson(Map<String, dynamic> json) =>
      SummaryMonthResponse(
        ganancy: (json['ganancy'] as num).toDouble(),
        idStateLoan: json['id_state_loan'],
        month: json['month'],
        year: json['year'],
      );

  Map<String, dynamic> toJson() => {
        'ganancy': ganancy,
        'id_state_loan': idStateLoan,
        'month': month,
        'year': year,
      };
}
