import 'dart:convert';

List<PaymentProviderEntity> paymentProviderEntityFromJson(String str) =>
    List<PaymentProviderEntity>.from(
        json.decode(str).map((x) => PaymentProviderEntity.fromJson(x)));

String paymentProviderEntityToJson(List<PaymentProviderEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentProviderEntity {
  int id;
  String name;
  String category;

  PaymentProviderEntity({
    required this.id,
    required this.name,
    required this.category,
  });

  factory PaymentProviderEntity.fromJson(Map<String, dynamic> json) =>
      PaymentProviderEntity(
        id: json["id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
      };

  // Mismos valores que paymentProviderCategories en loans_node (default_values.js).
  static const String bankCategory = 'BANK';
  static const String walletCategory = 'WALLET';

  bool get isBank => category == bankCategory;
  bool get isWallet => category == walletCategory;
}
