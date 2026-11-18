
class PaymentProviderEntity {
  int id;
  String name;
  String? description;

  PaymentProviderEntity({
    required this.id,
    required this.name,
    this.description,
  });

  factory PaymentProviderEntity.fromJson(Map<String, dynamic> json) =>
      PaymentProviderEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };

  static List<PaymentProviderEntity> get defaults => [
        PaymentProviderEntity(id: 1, name: 'Yape'),
        PaymentProviderEntity(id: 2, name: 'Plin'),
        PaymentProviderEntity(id: 3, name: 'BCP'),
        PaymentProviderEntity(id: 4, name: 'Interbank'),
        PaymentProviderEntity(id: 5, name: 'BBVA'),
        PaymentProviderEntity(id: 6, name: 'Scotiabank'),
        PaymentProviderEntity(id: 7, name: 'Otro'),
      ];

  static const int maxLengthOfAccountNumber = 20;
  static const int maxLengthOfCci = 20;
  static const int maxLengthOfPhone = 9;
  static const int maxLengthOfHolderName = 150;
}
