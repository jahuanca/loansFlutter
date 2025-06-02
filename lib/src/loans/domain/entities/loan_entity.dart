
// To parse this JSON data, do
//
//     final loanEntity = loanEntityFromJson(jsonString);

import 'dart:convert';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:utils/utils.dart';

List<LoanEntity> loanEntityFromJson(String str) => List<LoanEntity>.from(json.decode(str).map((x) => LoanEntity.fromJson(x)));

String loanEntityToJson(List<LoanEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanEntity {
    int? id;
    int idCustomer;
    int idUser;
    int idPaymentFrequency;
    double amount;
    double percentage;
    DateTime date;
    int ganancy;
    int idPaymentMethod;
    String? observation;
    int idStateLoan;
    String evidence;
    DateTime createdAt;
    DateTime updatedAt;
    CustomerEntity? customerEntity;

    LoanEntity({
        this.id,
        required this.idCustomer,
        required this.idUser,
        required this.idPaymentFrequency,
        required this.amount,
        required this.percentage,
        required this.date,
        required this.ganancy,
        required this.idPaymentMethod,
        required this.observation,
        required this.idStateLoan,
        required this.evidence,
        required this.createdAt,
        required this.updatedAt,
        this.customerEntity,
    });

    String get formatTitle => 'S/ ${amount.formatDecimals()} - ${percentage.formatDecimals()}%';

    factory LoanEntity.fromJson(Map<String, dynamic> json) => LoanEntity(
        id: json["id"],
        idCustomer: json["id_customer"],
        idUser: json["id_user"],
        idPaymentFrequency: json["id_payment_frequency"],
        amount: (json["amount"] as num).toDouble(),
        percentage: (json["percentage"] as num).toDouble(),
        date: DateTime.parse(json["date"]),
        ganancy: json["ganancy"],
        idPaymentMethod: json["id_payment_method"],
        observation: json["observation"],
        idStateLoan: json["id_state_loan"],
        evidence: json["evidence"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        customerEntity: json['Customer'] == null ? null : CustomerEntity.fromJson(json['Customer']),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_customer": idCustomer,
        "id_user": idUser,
        "id_payment_frequency": idPaymentFrequency,
        "amount": amount,
        "percentage": percentage,
        "date": date.toIso8601String(),
        "ganancy": ganancy,
        "id_payment_method": idPaymentMethod,
        "observation": observation,
        "id_state_loan": idStateLoan,
        "evidence": evidence,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        'Customer': customerEntity?.toJson(),
    };
}
