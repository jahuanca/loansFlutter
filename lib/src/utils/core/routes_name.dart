
enum RoutesName {
  bottomNavigationContent(route: '/NavigationContentPage'),
  quotaGroup(route: '/QuotaGroupPage')
  ;

  final String route;

  const RoutesName({
    required this.route,
  });
}