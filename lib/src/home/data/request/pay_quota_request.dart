
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
    idOfQuota: json['idOfQuota'], 
    paidDate: json['paidDate'],
  );

  Map<String, dynamic> toJson() => {
    'idOfQuota': idOfQuota,
    'paidDate': paidDate?.toIso8601String(),
  };
}