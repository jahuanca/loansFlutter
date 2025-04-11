import 'dart:convert';

List<TypeDocumentEntity> typeDocumentEntityFromJson(String str) => List<TypeDocumentEntity>.from(json.decode(str).map((x) => TypeDocumentEntity.fromJson(x)));

String typeDocumentEntityToJson(List<TypeDocumentEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeDocumentEntity {
    int id;
    String name;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    TypeDocumentEntity({
        required this.id,
        required this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory TypeDocumentEntity.fromJson(Map<String, dynamic> json) => TypeDocumentEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
