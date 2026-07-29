
enum HiveDbAdapters {
  summaryOfDashboard(source: 'utils/summary-of-dashboard'),
  loans(source: 'loans');

  const HiveDbAdapters({required this.source});

  final String source;
}

const int summaryOfDashboardIdAdapter = 0;
const int loanEntityIdAdapter = 1;
const int customerIdAdapter = 2;
const int paymentFrequencyIdAdapter = 3;