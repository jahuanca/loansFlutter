class CreateCustomerRequest {
  int? idTypeDocument;
  String? name;
  String? lastName;
  String? document;
  String? address;

  CreateCustomerRequest({
    this.idTypeDocument,
    this.name,
    this.lastName,
    this.document,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        'idTypeDocument': idTypeDocument,
        'name': name,
        'lastName': lastName,
        'document': document,
        'address': address,
      };

  factory CreateCustomerRequest.fromJson(Map<String, dynamic> json) =>
      CreateCustomerRequest(
        idTypeDocument: json['idTypeDocument'],
        name: json['name'],
        lastName: json['lastName'],
        document: json['document'],
        address: json['address'],
      );
}
