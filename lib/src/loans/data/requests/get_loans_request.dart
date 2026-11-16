class GetLoansRequest {
  int? idStateLoan;
  int? idCustomer;

  GetLoansRequest({
    this.idCustomer,
    this.idStateLoan,
  });

  factory GetLoansRequest.fromJson(Map<String, dynamic> json) =>
      GetLoansRequest(
        idCustomer: json['idCustomer'],
        idStateLoan: json['idStateLoan'],
      );

  Map<String, dynamic> toJson() => {
        'idCustomer': idCustomer,
        'idStateLoan': idStateLoan,
      };
}
