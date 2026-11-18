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

  // TODO: Lista local de proveedores de pago. Reemplazar por un endpoint
  // (p. ej. /utils/payment-providers) cuando exista en loans_node.
  static List<PaymentProviderEntity> get defaults => [
        PaymentProviderEntity(id: 1, name: 'Yape', category: 'Billetera digital'),
        PaymentProviderEntity(id: 2, name: 'Plin', category: 'Billetera digital'),
        PaymentProviderEntity(id: 3, name: 'BCP', category: 'Banco'),
        PaymentProviderEntity(id: 4, name: 'Interbank', category: 'Banco'),
        PaymentProviderEntity(id: 5, name: 'BBVA', category: 'Banco'),
        PaymentProviderEntity(id: 6, name: 'Scotiabank', category: 'Banco'),
        PaymentProviderEntity(id: 7, name: 'Otro', category: 'Otro'),
      ];
}
