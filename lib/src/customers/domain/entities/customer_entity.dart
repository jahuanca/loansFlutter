// To parse this JSON data, do
//
//     final customerEntity = customerEntityFromJson(jsonString);

import 'dart:convert';

List<CustomerEntity> customerEntityFromJson(String str) => List<CustomerEntity>.from(json.decode(str).map((x) => CustomerEntity.fromJson(x)));

String customerEntityToJson(List<CustomerEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerEntity {
    int id;
    String name;
    String lastName;
    String address;
    String? latitude;
    String? longitude;
    int idTypeDocument;
    String document;
    DateTime createdAt;
    DateTime updatedAt;

    CustomerEntity({
        required this.id,
        required this.name,
        required this.lastName,
        required this.address,
        this.latitude,
        this.longitude,
        required this.idTypeDocument,
        required this.document,
        required this.createdAt,
        required this.updatedAt,
    });

    String get fullName => '$name $lastName';

    factory CustomerEntity.fromJson(Map<String, dynamic> json) => CustomerEntity(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idTypeDocument: json["id_type_document"],
        document: json["document"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "id_type_document": idTypeDocument,
        "document": document,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "fullName": fullName,
    };
}
