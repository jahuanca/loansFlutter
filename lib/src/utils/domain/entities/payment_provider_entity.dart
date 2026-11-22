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
  static const String bankCategory = 'BANCO';
  static const String walletCategory = 'BILLETERA DIGITAL';

  bool get isBank => category == bankCategory;
  bool get isWallet => category == walletCategory;

  // TODO: Lista local de proveedores de pago. Reemplazar por un endpoint
  // (p. ej. /utils/payment-providers) cuando exista en loans_node.
  static List<PaymentProviderEntity> get defaults => [
        PaymentProviderEntity(id: 1, name: 'Yape', category: walletCategory),
        PaymentProviderEntity(id: 2, name: 'Plin', category: walletCategory),
        PaymentProviderEntity(id: 3, name: 'BCP', category: bankCategory),
        PaymentProviderEntity(id: 4, name: 'Interbank', category: bankCategory),
        PaymentProviderEntity(id: 5, name: 'BBVA', category: bankCategory),
        PaymentProviderEntity(id: 6, name: 'Scotiabank', category: bankCategory),
        PaymentProviderEntity(id: 7, name: 'Otro', category: 'Otro'),
      ];
}
