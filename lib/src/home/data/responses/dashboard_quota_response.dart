import 'dart:convert';
import 'package:loands_flutter/src/home/data/responses/state_quota_enum.dart';
import 'package:utils/utils.dart';

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
  double? amountOfLoan;
  double ganancy;
  int idStateQuota;
  DateTime dateToPay;
  DateTime? paidDate;
  bool isSpecial;
  bool isLast;

  double? amountOfLastLoan;

  DashboardQuotaResponse({
    required this.id,
    required this.idLoan,
    required this.name,
    required this.customerName,
    required this.amount,
    this.amountOfLoan,
    required this.ganancy,
    required this.idStateQuota,
    required this.dateToPay,
    required this.paidDate,
    required this.isSpecial,
    required this.isLast,
    this.alias,
    this.amountOfLastLoan,
  });

  String get aliasOrName => alias ?? customerName;

  StateQuotaEnum get stateQuota {
    return findStateQuotaEnum(idStateQuota) ?? StateQuotaEnum.pendingQuota;
  }

  factory DashboardQuotaResponse.fromJson(Map<String, dynamic> json) =>
    DashboardQuotaResponse(
      id: json["id"],
      idLoan: json["idLoan"],
      name: json["name"],
      isLast: json["isLast"],
      customerName: json["customerName"],
      alias: json["alias"],
      amount: json["amount"] == null ? 0 : (json["amount"] as num).toDouble(),
      amountOfLoan: json["amountOfLoan"] == null ? null : (json["amountOfLoan"] as num).toDouble(),
      amountOfLastLoan: json["amountOfLastLoan"] == null ? null : (json["amountOfLastLoan"] as num).toDouble(),
      ganancy: (json["ganancy"] as num).toDouble(),
      idStateQuota: json["idStateQuota"],
      isSpecial: json['isSpecial'],
      dateToPay: DateTime.parse(json['dateToPay']),
      paidDate: json['paidDate'] == null ? null : DateTime.tryParse(json['paidDate']),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLoan": idLoan,
        "name": name,
        "isLast": isLast,
        "alias": alias,
        "amount": amount,
        "amountOfLoan": amountOfLoan,
        "amountOfLastLoan": amountOfLastLoan,
        "ganancy": ganancy,
        "customerName": customerName,
        "idStateQuota": idStateQuota,
        'isSpecial': isSpecial,
        'dateToPay': dateToPay.toServer(),
        'paidDate': paidDate?.toServer(),
      };

  Map<String, dynamic> toJsonForRenewal() => {
        "id": id,
        "idLoan": idLoan,
        "name": name,
        "isLast": isLast,
        "alias": alias,
        "amount": amount,
        "amountOfLoan": amountOfLoan,
        "ganancy": ganancy,
        "customerName": customerName,
        "idStateQuota": idStateQuota,
        'isSpecial': isSpecial,
        'dateToPay': dateToPay.toServer(),
        'paidDate': paidDate?.toServer(),
      };
}