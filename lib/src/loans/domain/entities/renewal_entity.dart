class RenewalEntity {

  int idUser;
  int idPreviousLoan;
  int idNewLoan;
  DateTime date;
  double variationInAmount;
  int idTypeRenewal;
  String? observation;

  RenewalEntity({
    required this.idUser,
    required this.idPreviousLoan,
    required this.idNewLoan,
    required this.date,
    required this.variationInAmount,
    required this.idTypeRenewal,
    this.observation,
  });

  factory RenewalEntity.fromJson(Map<String, dynamic> json) => RenewalEntity(
    idUser: json['id_user'], 
    idPreviousLoan: json['id_previous_loan'], 
    idNewLoan: json['id_new_loan'], 
    date: DateTime.parse(json['date']), 
    variationInAmount: json['variation_in_amount'], 
    idTypeRenewal: json['id_type_renewal']);

  Map<String, dynamic> toJson() => {
    'id_user': idUser,
    'id_previous_loan': idPreviousLoan,
    'id_new_loan': idNewLoan,
    'date': date.toIso8601String(),
    'variation_in_amount': variationInAmount,
    'id_type_renewal': idTypeRenewal,
  };
}