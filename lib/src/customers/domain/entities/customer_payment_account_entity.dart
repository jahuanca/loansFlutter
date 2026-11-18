import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:utils/utils.dart';
part 'customer_payment_account_entity.g.dart';

List<CustomerPaymentAccountEntity> customerPaymentAccountEntityFromJson(
        String str) =>
    List<CustomerPaymentAccountEntity>.from(json
        .decode(str)
        .map((x) => CustomerPaymentAccountEntity.fromJson(x)));

String customerPaymentAccountEntityToJson(
        List<CustomerPaymentAccountEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: customerPaymentAccountIdAdapter)
class CustomerPaymentAccountEntity {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? idCustomer;
  @HiveField(2)
  int idPaymentProvider;
  @HiveField(3)
  String? accountNumber;
  @HiveField(4)
  String? cci;
  @HiveField(5)
  String? phone;
  @HiveField(6)
  String? holderName;
  @HiveField(7)
  DateTime? createdAt;
  @HiveField(8)
  DateTime? updatedAt;

  CustomerPaymentAccountEntity({
    this.id,
    this.idCustomer,
    required this.idPaymentProvider,
    this.accountNumber,
    this.cci,
    this.phone,
    this.holderName,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerPaymentAccountEntity.fromJson(Map<String, dynamic> json) =>
      CustomerPaymentAccountEntity(
        id: json["id"],
        idCustomer: json["idCustomer"],
        idPaymentProvider: json["idPaymentProvider"],
        accountNumber: json["accountNumber"],
        cci: json["cci"],
        phone: json["phone"],
        holderName: json["holderName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idCustomer": idCustomer,
        "idPaymentProvider": idPaymentProvider,
        "accountNumber": accountNumber,
        "cci": cci,
        "phone": phone,
        "holderName": holderName,
        "createdAt": createdAt?.toServer(),
        "updatedAt": updatedAt?.toServer(),
      };

  static const int maxLengthOfAccountNumber = 20;
  static const int maxLengthOfCci = 20;
  static const int maxLengthOfPhone = 9;
  static const int maxLengthOfHolderName = 150;
}
