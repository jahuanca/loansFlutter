
import 'dart:convert';

List<CapitalMovementEntity> capitalMovementsResponseFromJson(String str) =>
    List<CapitalMovementEntity>.from(
        json.decode(str).map((x) => CapitalMovementEntity.fromJson(x)));

class CapitalMovementEntity {
  int? id;
  String? type;
  String? description;
  double? amount;
  double? ganancy;

  CapitalMovementEntity({
    this.id,
    this.type,
    this.description,
    this.amount,
    this.ganancy,
  });

  factory CapitalMovementEntity.fromJson(Map<String, dynamic> json) => CapitalMovementEntity(
    id: json['id'],
    type: json['type'],
    description: json['description'],
    amount: (json['amount'] as num).toDouble(),
    ganancy: (json['ganancy'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'description': description,
    'amount': amount,
    'ganancy': ganancy,
  };

}