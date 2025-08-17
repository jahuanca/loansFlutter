import 'dart:convert';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';

List<SummaryMonthResponse> summaryMonthFromJson(String str) =>
    List<SummaryMonthResponse>.from(
        json.decode(str).map((x) => SummaryMonthResponse.fromJson(x)));

class SummaryMonthResponse {
  double ganancy;
  double amount;
  int idStateQuota;
  String month;
  String year;

  SummaryMonthResponse({
    required this.ganancy,
    required this.amount,
    required this.idStateQuota,
    required this.month,
    required this.year,
  });

  DateTime get time => DateTime(int.parse(year), int.parse(month));
  bool get isCompleted => (idStateQuota == idOfCompleteQuota);
  String get stateLoan => isCompleted ? 'Ganancia' : 'Pérdida';

  factory SummaryMonthResponse.fromJson(Map<String, dynamic> json) =>
      SummaryMonthResponse(
        ganancy: (json['ganancy'] as num).toDouble(),
        amount: (json['amount'] as num).toDouble(),
        idStateQuota: json['id_state_quota'],
        month: json['month'],
        year: json['year'],
      );

  Map<String, dynamic> toJson() => {
        'ganancy': ganancy,
        'amount': amount,
        'id_state_quota': idStateQuota,
        'month': month,
        'year': year,
      };
}
