
import 'package:utils/utils.dart';

class ValidateLoanRequest {

  int idCustomer;
  int idPaymentFrequency;
  double percentage;
  double amount;
  DateTime startDate;


  ValidateLoanRequest({
    required this.idCustomer,
    required this.idPaymentFrequency,
    required this.percentage,
    required this.amount,
    required this.startDate,
  });

  Map<String, dynamic> toJson() => {
    'idCustomer': idCustomer,
    'idPaymentFrequency': idPaymentFrequency,
    'percentage': percentage,
    'amount': amount,
    'startDate': startDate.toServer(),
  }; 
}