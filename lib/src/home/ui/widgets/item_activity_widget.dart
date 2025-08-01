import 'package:flutter/material.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';
import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/description_operation_of_log.dart';

class ItemActivityWidget extends StatelessWidget {
  final ActivityLogEntity log;

  const ItemActivityWidget({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final String dateTimeFormat = log.createdAt
        .format(formatDate: formatOfActivity)
        .orEmpty()
        .toCapitalize();

    return SizedBox(
      child: ListTile(
        leading: _iconLeading,
        title: Text(_description),
        subtitle: Text(dateTimeFormat),
        trailing: _iconTrailing,
      ),
    );
  }

  String get _description {
    switch (log.descriptionOperation) {
      case DescriptionOperationOfLog.payQuota:
        QuotaEntity quota = QuotaEntity.fromJson(log.newRegistry);
        return 'P#${quota.idLoan}, se pagó la cuota ${quota.name}';
      case DescriptionOperationOfLog.createSpecialLoan:
      case DescriptionOperationOfLog.createLoan:
        LoanEntity loan = LoanEntity.fromJson(log.newRegistry);
        return 'P#${loan.id} de S/ ${loan.amount.formatDecimals()} para ${loan.idCustomer}';
      case DescriptionOperationOfLog.createCustomer:
        return 'Se creó un nuevo cliente, Jose Antonio Huanca Ancajima';
      default:
        return 'Sin descripción';
    }
  }

  Widget? get _iconTrailing {
    switch (log.descriptionOperation) {
      case DescriptionOperationOfLog.payQuota:
        QuotaEntity quota = QuotaEntity.fromJson(log.newRegistry);
        return Text('+ ${quota.ganancy.formatDecimals()}');
      case DescriptionOperationOfLog.createSpecialLoan:
      case DescriptionOperationOfLog.createLoan:
      case DescriptionOperationOfLog.createCustomer:
      default:
        return null;
    }
  }

  Widget get _iconLeading {
    switch (log.descriptionOperation) {
      case DescriptionOperationOfLog.payQuota:
        return Icon(Icons.monetization_on_outlined, color: successColor(),);
      case DescriptionOperationOfLog.createSpecialLoan:
      case DescriptionOperationOfLog.createLoan:
        return Icon(Icons.fiber_new_rounded, color: infoColor());
      case DescriptionOperationOfLog.createCustomer:
        return const Icon(Icons.person_add_alt);
      default:
        return const Icon(Icons.abc);
    }
  }
}
