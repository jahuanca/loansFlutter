import 'dart:convert';

import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:utils/utils.dart';

List<QuotaEntity> quotaEntityFromJson(String str) => List<QuotaEntity>.from(
    json.decode(str).map((x) => QuotaEntity.fromJson(x)));

String quotaEntityToJson(List<QuotaEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuotaEntity {
  int? id;
  String name;
  String description;
  int? idLoan;
  double amount;
  double ganancy;
  DateTime dateToPay;
  DateTime? paidDate;
  double? amountDelinquency;
  int idStateQuota;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isLast;

  QuotaEntity({
    this.id,
    required this.name,
    required this.description,
    this.idLoan,
    required this.amount,
    required this.dateToPay,
    this.paidDate,
    this.amountDelinquency,
    required this.idStateQuota,
    required this.ganancy,
    required this.isLast,
    this.createdAt,
    this.updatedAt,
  });

  factory QuotaEntity.fromJson(Map<String, dynamic> json) => QuotaEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        idLoan: json["idLoan"],
        isLast: json["isLast"],
        amount: (json["amount"] as num).toDouble(),
        ganancy: (json["ganancy"] as num).toDouble(),
        dateToPay: DateTime.parse(json["dateToPay"]),
        paidDate: json["paidDate"] == null
            ? null
            : DateTime.tryParse(json["paidDate"]),
        amountDelinquency: json["amountDelinquency"],
        idStateQuota: json["idStateQuota"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "idLoan": idLoan,
        "isLast": isLast,
        "amount": amount,
        "ganancy": ganancy,
        "dateToPay": dateToPay.toServer(),
        "paidDate": paidDate?.toServer(),
        "amountDelinquency": amountDelinquency,
        "idStateQuota": idStateQuota,
        "createdAt": createdAt?.toServer(),
        "updatedAt": updatedAt?.toServer(),
      };
}

toDashboardResponse({
  required LoanEntity newLoan,
  required QuotaEntity quota,
  required String customerName,
  required bool isSpecial,
  required bool isLast,
}) =>
    DashboardQuotaResponse(
        id: quota.id.orZero(),
        idLoan: quota.idLoan.orZero(),
        name: quota.name,
        customerName: customerName,
        amount: quota.amount,
        ganancy: quota.ganancy,
        idStateQuota: quota.idStateQuota,
        dateToPay: quota.dateToPay,
        paidDate: quota.paidDate,
        isSpecial: isSpecial,
        isLast: isLast,
      );
