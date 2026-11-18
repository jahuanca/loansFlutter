import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
part 'customer_entity.g.dart';

List<CustomerEntity> customerEntityFromJson(String str) => List<CustomerEntity>.from(json.decode(str).map((x) => CustomerEntity.fromJson(x)));

String customerEntityToJson(List<CustomerEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: customerIdAdapter)
class CustomerEntity {
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;
    @HiveField(2)
    String? alias;
    @HiveField(3)
    String lastName;
    @HiveField(4)
    String address;
    @HiveField(5)
    String? latitude;
    @HiveField(6)
    String? longitude;
    @HiveField(7)
    String? phone;
    @HiveField(8)
    int idTypeDocument;
    @HiveField(9)
    int idTypeCustomer;
    @HiveField(10)
    String document;
    @HiveField(11)
    DateTime createdAt;
    @HiveField(12)
    DateTime updatedAt;
    @HiveField(13)
    int idAssignedRecoveryAgent;
    @HiveField(14)
    CustomerPaymentAccountEntity? customerPaymentAccountEntity;


    CustomerEntity({
        required this.id,
        required this.idAssignedRecoveryAgent,
        required this.name,
        required this.lastName,
        required this.address,
        required this.idTypeCustomer,
        required this.idTypeDocument,
        required this.document,
        required this.createdAt,
        required this.updatedAt,
        this.phone,
        this.alias,
        this.latitude,
        this.longitude,
        this.customerPaymentAccountEntity,
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
        idAssignedRecoveryAgent: json["idAssignedRecoveryAgent"],
        alias: json["alias"],
        name: json["name"],
        lastName: json["lastName"],
        address: json["address"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idTypeCustomer: json["idTypeCustomer"],
        idTypeDocument: json["idTypeDocument"],
        document: json["document"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        customerPaymentAccountEntity: json["customerPaymentAccount"] == null
            ? null
            : CustomerPaymentAccountEntity.fromJson(json["customerPaymentAccount"]),
    );

    Map<String, dynamic> toDropdown() => {
      'id': id,
      'aliasOrFullName': aliasOrFullName,
    };

    Map<String, dynamic> toJson() => {
        "id": id,
        "idAssignedRecoveryAgent": idAssignedRecoveryAgent,
        "alias": alias,
        "name": name,
        "lastName": lastName,
        "address": address,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "idTypeCustomer": idTypeCustomer,
        "idTypeDocument": idTypeDocument,
        "document": document,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "customerPaymentAccount": customerPaymentAccountEntity?.toJson(),
        "fullName": fullName,
        'aliasOrFullName': aliasOrFullName,
    };

    static const int maxLenghtOfAlias = 50;
    static const int maxLenghtOfDocument = 8;
}
