enum HiveDbAdapters {
  summaryOfDashboard(source: '/utils/summary-of-dashboard'),
  loans(source: '/loans'),
  paymentMethod(source: '/utils/payment-method'),
  paymentFrequency(source: '/utils/payment-frequency'),;

  const HiveDbAdapters({required this.source});

  final String source;
}

const int summaryOfDashboardIdAdapter = 0;
const int loanEntityIdAdapter = 1;
const int customerIdAdapter = 2;
const int paymentFrequencyIdAdapter = 3;
const int paymentMethodIdAdapter = 4;
