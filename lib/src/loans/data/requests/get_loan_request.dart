class GetLoanRequest {
  int? id;

  GetLoanRequest({
    this.id,
  });

  factory GetLoanRequest.fromJson(Map<String, dynamic> json) =>
      GetLoanRequest(
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
