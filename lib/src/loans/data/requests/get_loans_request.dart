class GetLoansRequest {
  int? idStateLoan;
  int? idCustomer;

  GetLoansRequest({
    this.idCustomer,
    this.idStateLoan,
  });

  factory GetLoansRequest.fromJson(Map<String, dynamic> json) =>
      GetLoansRequest(
        idCustomer: json['id_customer'],
        idStateLoan: json['id_state_loan'],
      );

  Map<String, dynamic> toJson() => {
        'id_customer': idCustomer,
        'id_state_loan': idStateLoan,
      };
}
