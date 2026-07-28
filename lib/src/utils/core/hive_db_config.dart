
enum HiveDbAdapters {
  summaryOfDashboard(source: 'utils/summary-of-dashboard');

  const HiveDbAdapters({required this.source});

  final String source;
}

const int summaryOfDashboardIdAdapter = 0;