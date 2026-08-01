import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:utils/utils.dart';
part 'payment_frequency_entity.g.dart';

List<PaymentFrequencyEntity> paymentFrequencyEntityFromJson(String str) =>
    List<PaymentFrequencyEntity>.from(
        json.decode(str).map((x) => PaymentFrequencyEntity.fromJson(x)));

String paymentFrequencyEntityToJson(List<PaymentFrequencyEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: paymentFrequencyIdAdapter)
class PaymentFrequencyEntity {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? idTypeCustomer;
  @HiveField(2)
  String name;
  @HiveField(3)
  String? description;
  @HiveField(4)
  double recommendedPercentage;
  @HiveField(5)
  int monthlyInstallments;
  @HiveField(6)
  int daysInstallment;
  @HiveField(7)
  DateTime createdAt;
  @HiveField(8)
  DateTime updatedAt;

  PaymentFrequencyEntity({
    this.id,
    required this.name,
    required this.idTypeCustomer,
    this.description,
    required this.recommendedPercentage,
    required this.monthlyInstallments,
    required this.daysInstallment,
    required this.createdAt,
    required this.updatedAt,
  });

  String get titleItem => '$name - $description';

  factory PaymentFrequencyEntity.fromJson(Map<String, dynamic> json) =>
      PaymentFrequencyEntity(
        id: json["id"],
        idTypeCustomer: json["id_type_customer"],
        name: json["name"],
        description: json["description"],
        recommendedPercentage:
            (json["recommended_percentage"] as num).toDouble(),
        monthlyInstallments: json["monthly_installments"],
        daysInstallment: json["days_installment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_type_customer": idTypeCustomer,
        "name": name,
        "description": description,
        "recommended_percentage": recommendedPercentage,
        "createdAt": createdAt.toServer(),
        "updatedAt": updatedAt.toServer(),
        "titleItem": titleItem,
        'monthly_installments': monthlyInstallments,
        'days_installment': daysInstallment,
      };
}
