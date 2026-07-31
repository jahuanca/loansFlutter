import 'dart:convert';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:hive/hive.dart';
part 'payment_method_entity.g.dart';

List<PaymentMethodEntity> paymentMethodEntityFromJson(String str) => List<PaymentMethodEntity>.from(json.decode(str).map((x) => PaymentMethodEntity.fromJson(x)));

String paymentMethodEntityToJson(List<PaymentMethodEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: paymentMethodIdAdapter)
class PaymentMethodEntity {
    @HiveField(0)
    int? id;
    @HiveField(1)
    String name;
    @HiveField(2)
    String description;
    @HiveField(3)
    DateTime createdAt;
    @HiveField(4)
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
