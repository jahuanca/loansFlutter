
class GetAllQuotasRequest {

  int? idLoan;

  GetAllQuotasRequest({
    this.idLoan,
  });

  factory GetAllQuotasRequest.fromJson(Map<String, dynamic> json) => GetAllQuotasRequest(
    idLoan: json['idLoan'],
  );

  Map<String, dynamic> toJson() => {
    'idLoan': idLoan,
  };

}