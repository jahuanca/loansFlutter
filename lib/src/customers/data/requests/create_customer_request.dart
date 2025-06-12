class CreateCustomerRequest {
  int? id;
  int? idTypeDocument;
  String? alias;
  String? name;
  String? lastName;
  String? document;
  String? address;

  CreateCustomerRequest({
    this.id,
    this.idTypeDocument,
    this.name,
    this.lastName,
    this.document,
    this.address,
    this.alias,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_type_document': idTypeDocument,
        'alias': alias,
        'name': name,
        'lastName': lastName,
        'document': document,
        'address': address,
      };

  factory CreateCustomerRequest.fromJson(Map<String, dynamic> json) =>
      CreateCustomerRequest(
        id: json['id'],
        idTypeDocument: json['id_type_document'],
        alias: json['alias'],
        name: json['name'],
        lastName: json['lastName'],
        document: json['document'],
        address: json['address'],
      );
}
