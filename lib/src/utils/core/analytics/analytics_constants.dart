

class AnalyticsConstants {

  
  static String createCustomerSuccess() {
    return 'new_customer';
  }

  static String createLoan({
    required String amount,
    required String frequency, 
  }) {
    return 'create_loan, amount: $amount, frequency: $frequency';
  }

}