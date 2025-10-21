
import 'package:utils/utils.dart';

class AddRenewalRequest {

  int? idCustomer;
  int? idPreviousLoan;
  int? idNewLoan;
  DateTime? date;
  double? variationInAmount;
  int? idTypeRenewal;
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

  bool get validate {
    return [idCustomer, idNewLoan, idPreviousLoan, date, variationInAmount, idTypeRenewal].contains(null).not();
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