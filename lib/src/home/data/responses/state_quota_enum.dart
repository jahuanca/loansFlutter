import 'package:flutter/material.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';

enum StateQuotaEnum {

  pendingQuota(
    id: idOfPendingQuota,
    color: Colors.red, 
    name: 'Pendiente'
  ),
  completeQuota(
    id: idOfCompleteQuota,
    color: Colors.green,
    name: 'Completo'
  );

  const StateQuotaEnum({
    required this.id,
    required this.color,
    required this.name,
  });

  final int id;
  final Color color;
  final String name;
}

StateQuotaEnum? findStateQuotaEnum(int? idStateQuota) {
  if (idStateQuota == null) {
    return null;
  }
  return StateQuotaEnum.values.firstWhere((e) => e.id == idStateQuota);
}