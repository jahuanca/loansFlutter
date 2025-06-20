import 'dart:convert';

import 'package:flutter/material.dart';

List<DashboardQuotaResponse> dashboardQuotasResponseFromJson(String str) =>
    List<DashboardQuotaResponse>.from(
        json.decode(str).map((x) => DashboardQuotaResponse.fromJson(x)));

String dashboardQuotasResponseToJson(List<DashboardQuotaResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardQuotaResponse {
  int id;
  String name;
  String customerName;
  String? alias;
  double amount;
  int idStateQuota;
  DateTime dateToPay;

  DashboardQuotaResponse({
    required this.id,
    required this.name,
    required this.customerName,
    required this.amount,
    required this.idStateQuota,
    required this.dateToPay,
    this.alias,
  });

  Map<String, dynamic> get stateQuota {
    switch (idStateQuota) {
      case 1:
        return {
          'color': Colors.red,
          'name': 'Pendiente',
        };
      case 2:
        return {
          'color': Colors.green,
          'name': 'Pagado',
        };
      default:
        return {
          'color': Colors.white,
          'name': 'Sin estado',
        };
    }
  }

  factory DashboardQuotaResponse.fromJson(Map<String, dynamic> json) =>
      DashboardQuotaResponse(
        id: json["id"],
        name: json["name"],
        customerName: json["customer_name"],
        alias: json["alias"],
        amount: (json["amount"] as num).toDouble(),
        idStateQuota: json["id_state_quota"],
        dateToPay: DateTime.parse(json['date_to_pay']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alias": alias,
        "customer_name": customerName,
        "id_state_quota": idStateQuota,
        'date_to_pay': dateToPay.toIso8601String(),
      };
}
