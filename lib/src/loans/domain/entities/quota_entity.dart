// To parse this JSON data, do
//
//     final quotaEntity = quotaEntityFromJson(jsonString);

import 'dart:convert';

List<QuotaEntity> quotaEntityFromJson(String str) => List<QuotaEntity>.from(json.decode(str).map((x) => QuotaEntity.fromJson(x)));

String quotaEntityToJson(List<QuotaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuotaEntity {
    int? id;
    String name;
    String description;
    int idLoan;
    double amount;
    DateTime dateToPay;
    DateTime? paidDate;
    double? amountDelinquency;
    DateTime idStateQuota;
    DateTime createdAt;
    DateTime updatedAt;

    QuotaEntity({
        this.id,
        required this.name,
        required this.description,
        required this.idLoan,
        required this.amount,
        required this.dateToPay,
        this.paidDate,
        this.amountDelinquency,
        required this.idStateQuota,
        required this.createdAt,
        required this.updatedAt,
    });

    factory QuotaEntity.fromJson(Map<String, dynamic> json) => QuotaEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        idLoan: json["id_loan"],
        amount: (json["amount"] as num).toDouble(),
        dateToPay: DateTime.parse(json["date_to_pay"]),
        paidDate: json["paid_date"],
        amountDelinquency: json["amount_delinquency"],
        idStateQuota: DateTime.parse(json["id_state_quota"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "id_loan": idLoan,
        "amount": amount,
        "date_to_pay": dateToPay.toIso8601String(),
        "paid_date": paidDate,
        "amount_delinquency": amountDelinquency,
        "id_state_quota": idStateQuota.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
