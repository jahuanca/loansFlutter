
import 'dart:convert';

import 'package:loands_flutter/src/utils/domain/entities/description_operation_of_log.dart';
import 'package:utils/utils.dart';

List<ActivityLogEntity> activityLogEntityFromJson(String str) => List<ActivityLogEntity>.from(json.decode(str).map((x) => ActivityLogEntity.fromJson(x)));

String paymentMethodEntityToJson(List<ActivityLogEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityLogEntity {

  int id;
  String tableName;
  String typeOperation;
  DescriptionOperationOfLog descriptionOperation;
  Map<String, dynamic> newRegistry;
  Map<String, dynamic>? oldRegistry;
  DateTime createdAt;
  int idUser;

  ActivityLogEntity({
    required this.id,
    required this.tableName,
    required this.typeOperation,
    required this.descriptionOperation,
    required this.newRegistry,
    required this.oldRegistry,
    required this.idUser,
    required this.createdAt,
  });

  factory ActivityLogEntity.fromJson(Map<String, dynamic> json) => ActivityLogEntity(
    id: json['id'], 
    tableName: json['tableName'], 
    typeOperation: json['typeOperation'], 
    descriptionOperation: DescriptionOperationOfLog.values
      .firstWhere((e) => json['descriptionOperation'] == e.title, orElse: () => DescriptionOperationOfLog.none,), 
    newRegistry: json['newRegistry'], 
    oldRegistry: json['oldRegistry'], 
    idUser: json['idUser'], 
    createdAt: DateTime.parse(json['createdAt']));

  Map<String, dynamic> toJson() => {
    'id': id, 
    'tableName': tableName,
    'typeOperation': typeOperation,
    'descriptionOperation': descriptionOperation,
    'newRegistry': newRegistry,
    'oldRegistry': oldRegistry,
    'idUser': idUser,
    'createdAt': createdAt.toServer(),
  };
}