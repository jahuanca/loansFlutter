import 'dart:convert';

List<CustomerEntity> customerEntityFromJson(String str) => List<CustomerEntity>.from(json.decode(str).map((x) => CustomerEntity.fromJson(x)));

String customerEntityToJson(List<CustomerEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerEntity {
    int id;
    String name;
    String? alias;
    String lastName;
    String address;
    String? latitude;
    String? longitude;
    int idTypeDocument;
    int idTypeCustomer;
    String document;
    DateTime createdAt;
    DateTime updatedAt;

    CustomerEntity({
        required this.id,
        required this.name,
        required this.lastName,
        required this.address,
        required this.idTypeCustomer,
        required this.idTypeDocument,
        required this.document,
        required this.createdAt,
        required this.updatedAt,
        this.alias,
        this.latitude,
        this.longitude,
    });

    String get aliasOrFullName => alias ?? fullName;

    String get fullName => '$name $lastName';

    bool containValue(String value) {
      value = value.toLowerCase().trim();
      if(aliasOrFullName.toLowerCase().contains(value)) return true;
      return false;
    }

    factory CustomerEntity.fromJson(Map<String, dynamic> json) => CustomerEntity(
        id: json["id"],
        alias: json["alias"],
        name: json["name"],
        lastName: json["lastName"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idTypeCustomer: json["id_type_customer"],
        idTypeDocument: json["id_type_document"],
        document: json["document"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toDropdown() => {
      'id': id,
      'aliasOrFullName': aliasOrFullName,
    };

    Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "name": name,
        "lastName": lastName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "id_type_customer": idTypeCustomer,
        "id_type_document": idTypeDocument,
        "document": document,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "fullName": fullName,
        'aliasOrFullName': aliasOrFullName,
    };

    static const int maxLenghtOfAlias = 50;
    static const int maxLenghtOfDocument = 8;
}
