class CreateCustomerRequest {
  int? id;
  int? idTypeDocument;
  int? idTypeCustomer;
  String? alias;
  String? name;
  String? lastName;
  String? document;
  String? address;

  CreateCustomerRequest({
    this.id,
    this.idTypeDocument,
    this.idTypeCustomer,
    this.name,
    this.lastName,
    this.document,
    this.address,
    this.alias,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_type_document': idTypeDocument,
        'id_type_customer': idTypeCustomer,
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
        idTypeCustomer: json['id_type_customer'],
        alias: json['alias'],
        name: json['name'],
        lastName: json['lastName'],
        document: json['document'],
        address: json['address'],
      );
}
