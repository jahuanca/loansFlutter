
class PayQuotaRequest {

  int idOfQuota;
  DateTime paidDate;

  PayQuotaRequest({
    required this.idOfQuota,
    required this.paidDate,
  });

  factory PayQuotaRequest.fromJson(Map<String, dynamic> json) => PayQuotaRequest(
    idOfQuota: json['idOfQuota'], 
    paidDate: json['paidDate'],
  );

  Map<String, dynamic> toJson() => {
    'idOfQuota': idOfQuota,
    'paidDate': paidDate.toIso8601String(),
  };
}