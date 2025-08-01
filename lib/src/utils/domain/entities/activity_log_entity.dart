
import 'dart:convert';

import 'package:loands_flutter/src/utils/domain/entities/description_operation_of_log.dart';

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
    tableName: json['table_name'], 
    typeOperation: json['type_operation'], 
    descriptionOperation: DescriptionOperationOfLog.values
      .firstWhere((e) => json['description_operation'] == e.title, orElse: () => DescriptionOperationOfLog.none,), 
    newRegistry: json['new_registry'], 
    oldRegistry: json['old_registry'], 
    idUser: json['id_user'], 
    createdAt: DateTime.parse(json['createdAt']));

  Map<String, dynamic> toJson() => {
    'id': id, 
    'table_name': tableName,
    'type_operation': typeOperation,
    'description_operation': descriptionOperation,
    'new_registry': newRegistry,
    'old_registry': oldRegistry,
    'id_user': idUser,
    'createdAt': createdAt.toLocal(),
  };
}