// To parse this JSON data, do
//
//     final paymentMethodEntity = paymentMethodEntityFromJson(jsonString);

import 'dart:convert';

List<PaymentMethodEntity> paymentMethodEntityFromJson(String str) => List<PaymentMethodEntity>.from(json.decode(str).map((x) => PaymentMethodEntity.fromJson(x)));

String paymentMethodEntityToJson(List<PaymentMethodEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodEntity {
    int? id;
    String name;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    PaymentMethodEntity({
        this.id,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PaymentMethodEntity.fromJson(Map<String, dynamic> json) => PaymentMethodEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
