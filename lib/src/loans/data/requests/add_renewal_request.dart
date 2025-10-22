class AddRenewalRequest {

  int? idCustomer;
  int? idPreviousLoan;
  int? idNewLoan;
  DateTime? date;
  double? variationInAmount;
  String? idTypeRenewal;
  String? observation;

  AddRenewalRequest({
    this.idCustomer,
    this.idNewLoan,
    this.idPreviousLoan,
    this.date,
    this.variationInAmount,
    this.idTypeRenewal,
    this.observation,
  });

  String? get validate {
    if (idCustomer == null) return 'Seleccione un cliente';
    if (idNewLoan == null) return 'Seleccione un nuevo crédito';
    if (date == null) return 'Fecha de renovación es necesaria';
    if (variationInAmount == null) return 'Variación es necesaria';
    if (idTypeRenewal == null) return 'Tipo de renovación es necesario.';
    return null;
  }

  Map<String, dynamic> toJson() => {
    'id_customer': idCustomer,
    'id_new_loan': idNewLoan,
    'id_previous_loan': idPreviousLoan,
    'date': date?.toIso8601String(),
    'variation_in_amount': variationInAmount,
    'id_type_renewal': idTypeRenewal,
    'observation': observation,
  };

}