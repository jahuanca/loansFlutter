
import 'package:utils/utils.dart';

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
    idStateQuota: json['idStateQuota'],
    fromDate: json['fromDate'],
    untilDate: json['untilDate'],
  );

  Map<String, dynamic> toJson() => {
    'idStateQuota': idStateQuota,
    'fromDate': fromDate?.toServer(),
    'untilDate': untilDate?.toServer(),
  };

}