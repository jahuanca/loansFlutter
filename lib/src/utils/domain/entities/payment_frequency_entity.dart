import 'dart:convert';

List<PaymentFrequencyEntity> paymentFrequencyEntityFromJson(String str) =>
    List<PaymentFrequencyEntity>.from(
        json.decode(str).map((x) => PaymentFrequencyEntity.fromJson(x)));

String paymentFrequencyEntityToJson(List<PaymentFrequencyEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentFrequencyEntity {
  int? id;
  int? idTypeCustomer;
  String name;
  String? description;
  double recommendedPercentage;
  int monthlyInstallments;
  int daysInstallment;
  DateTime createdAt;
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "titleItem": titleItem,
        'monthly_installments': monthlyInstallments,
        'days_installment': daysInstallment,
      };
}
