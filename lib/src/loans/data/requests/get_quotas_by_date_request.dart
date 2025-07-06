
class GetQuotasByDateRequest {

  int? idStateQuota;
  DateTime? fromDate;
  DateTime? untilDate;

  GetQuotasByDateRequest({
    this.idStateQuota,
    this.fromDate,
    this.untilDate,
  });

  factory GetQuotasByDateRequest.fromJson(Map<String, dynamic> json) => GetQuotasByDateRequest(
    idStateQuota: json['id_state_quota'],
    fromDate: json['from_date'],
    untilDate: json['until_date'],
  );

  Map<String, dynamic> toJson() => {
    'id_state_quota': idStateQuota,
    'from_date': fromDate,
    'until_date': untilDate,
  };

}