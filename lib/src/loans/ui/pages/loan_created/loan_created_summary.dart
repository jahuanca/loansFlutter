import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';

/// Datos que la pantalla de "Préstamo creado" necesita mostrar y compartir.
/// Se arma en el controller que crea el préstamo y viaja por `Get.arguments`.
class LoanCreatedSummary {
  final int? idLoan;
  final String customerName;
  final String? phone;
  final double amount;
  final List<QuotaEntity> quotas;

  /// Texto listo para compartir (lo arma `share_loan_util.dart`).
  final String information;

  /// true cuando viene de una renovación (cambia el título de la pantalla).
  final bool isRenewal;

  LoanCreatedSummary({
    required this.idLoan,
    required this.customerName,
    required this.phone,
    required this.amount,
    required this.quotas,
    required this.information,
    this.isRenewal = false,
  });

  bool get hasPhone => phone != null && phone!.trim().isNotEmpty;
}
