
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
    'id_customer': idCustomer,
    'id_payment_frequency': idPaymentFrequency,
    'percentage': percentage,
    'amount': amount,
    'start_date': startDate.toIso8601String(),
  }; 
}