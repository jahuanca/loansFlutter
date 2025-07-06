
class PayQuotaRequest {

  int? idOfQuota;
  DateTime? paidDate;

  PayQuotaRequest({
    this.idOfQuota,
    this.paidDate,
  });

  String? get messageError {
    if(idOfQuota == null) return 'idOfQuota es un valor necesario';
    if(paidDate == null) return 'Fecha de pago es un valor necesario';
    return null;
  }

  factory PayQuotaRequest.fromJson(Map<String, dynamic> json) => PayQuotaRequest(
    idOfQuota: json['id_of_quota'], 
    paidDate: json['paid_date'],
  );

  Map<String, dynamic> toJson() => {
    'id_of_quota': idOfQuota,
    'paid_date': paidDate?.toIso8601String(),
  };
}