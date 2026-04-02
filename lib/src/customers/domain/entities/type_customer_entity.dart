

import 'dart:convert';

List<TypeCustomerEntity> typeCustomerEntityFromJson(String str) => List<TypeCustomerEntity>.from(json.decode(str).map((x) => TypeCustomerEntity.fromJson(x)));

String typeCustomerEntityToJson(List<TypeCustomerEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class TypeCustomerEntity {

  int? id;
  String name;
  String description;

  TypeCustomerEntity({
    this.id,
    required this.name,
    required this.description,
  });

  factory TypeCustomerEntity.fromJson(Map<String, dynamic> json) => TypeCustomerEntity(
    id: json['id'],
    name: json['name'], 
    description: json['description'],
  );

  Map toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };

}