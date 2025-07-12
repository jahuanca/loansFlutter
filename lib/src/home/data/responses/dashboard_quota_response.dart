import 'dart:convert';
import 'package:loands_flutter/src/home/data/responses/state_quota_enum.dart';

List<DashboardQuotaResponse> dashboardQuotasResponseFromJson(String str) =>
    List<DashboardQuotaResponse>.from(
        json.decode(str).map((x) => DashboardQuotaResponse.fromJson(x)));

String dashboardQuotasResponseToJson(List<DashboardQuotaResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardQuotaResponse {
  int id;
  int idLoan;
  String name;
  String customerName;
  String? alias;
  double amount;
  double ganancy;
  int idStateQuota;
  DateTime dateToPay;
  DateTime? paidDate;
  

  DashboardQuotaResponse({
    required this.id,
    required this.idLoan,
    required this.name,
    required this.customerName,
    required this.amount,
    required this.ganancy,
    required this.idStateQuota,
    required this.dateToPay,
    required this.paidDate,
    this.alias,
  });

  String get aliasOrName => alias ?? customerName;

  StateQuotaEnum get stateQuota => findStateQuotaEnum(idStateQuota);

  factory DashboardQuotaResponse.fromJson(Map<String, dynamic> json) =>
    DashboardQuotaResponse(
      id: json["id"],
      idLoan: json["id_loan"],
      name: json["name"],
      customerName: json["customer_name"],
      alias: json["alias"],
      amount: (json["amount"] as num).toDouble(),
      ganancy: (json["ganancy"] as num).toDouble(),
      idStateQuota: json["id_state_quota"],
      dateToPay: DateTime.parse(json['date_to_pay']),
      paidDate: json['paid_date'] == null ? null : DateTime.tryParse(json['paid_date']),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_loan": idLoan,
        "name": name,
        "alias": alias,
        "amount": amount,
        "ganancy": ganancy,
        "customer_name": customerName,
        "id_state_quota": idStateQuota,
        'date_to_pay': dateToPay.toIso8601String(),
        'paid_date': paidDate?.toIso8601String(),
      };
}