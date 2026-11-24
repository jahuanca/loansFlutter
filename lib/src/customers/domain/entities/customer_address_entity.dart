import 'dart:convert';

List<CustomerAddressEntity> customerAddressEntityFromJson(String str) =>
    List<CustomerAddressEntity>.from(
        json.decode(str).map((x) => CustomerAddressEntity.fromJson(x)));

/// Valores de `customerAddressTypes` en loans_node (default_values.js).
/// `toJson` devuelve id/name para que DropdownWidget (paquete utils) lo pueda pintar.
enum CustomerAddressType {
  home('HOME', 'Casa'),
  business('BUSINESS', 'Negocio'),
  family('FAMILY', 'Familiar'),
  other('OTHER', 'Otro');

  final String value;
  final String label;

  const CustomerAddressType(this.value, this.label);

  static CustomerAddressType fromValue(String? value) =>
      CustomerAddressType.values.firstWhere(
        (e) => e.value == value,
        orElse: () => CustomerAddressType.other,
      );

  Map<String, dynamic> toJson() => {'id': value, 'name': label};
}

/// Direccion de un cliente (tabla customer_addresses). Sin Hive: solo se usa en linea.
class CustomerAddressEntity {
  int id;
  int idCustomer;
  String type;
  String address;
  String? reference;
  double? latitude;
  double? longitude;
  String image;
  bool isPrimary;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomerAddressEntity({
    required this.id,
    required this.idCustomer,
    required this.type,
    required this.address,
    required this.image,
    this.reference,
    this.latitude,
    this.longitude,
    this.isPrimary = false,
    this.createdAt,
    this.updatedAt,
  });

  CustomerAddressType get typeOfAddress => CustomerAddressType.fromValue(type);

  bool get hasCoordinates => latitude != null && longitude != null;

  // Postgres devuelve DECIMAL como string ("-12.046374"): se acepta string o numero.
  static double? _toDouble(dynamic value) =>
      value == null ? null : double.tryParse(value.toString());

  factory CustomerAddressEntity.fromJson(Map<String, dynamic> json) =>
      CustomerAddressEntity(
        id: json['id'],
        idCustomer: json['idCustomer'],
        type: json['type'],
        address: json['address'],
        reference: json['reference'],
        latitude: _toDouble(json['latitude']),
        longitude: _toDouble(json['longitude']),
        image: json['image'],
        isPrimary: json['isPrimary'] ?? false,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt']),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.tryParse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'idCustomer': idCustomer,
        'type': type,
        'address': address,
        'reference': reference,
        'latitude': latitude,
        'longitude': longitude,
        'image': image,
        'isPrimary': isPrimary,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  static const int maxLengthOfAddress = 150;
  static const int maxLengthOfReference = 200;
}
