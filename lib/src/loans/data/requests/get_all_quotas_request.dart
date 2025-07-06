
class GetAllQuotasRequest {

  int? idLoan;

  GetAllQuotasRequest({
    this.idLoan,
  });

  factory GetAllQuotasRequest.fromJson(Map<String, dynamic> json) => GetAllQuotasRequest(
    idLoan: json['id_loan'],
  );

  Map<String, dynamic> toJson() => {
    'id_loan': idLoan,
  };

}