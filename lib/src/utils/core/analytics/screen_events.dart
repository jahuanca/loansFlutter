
enum ScreenEvents {

  paymentSummary(
    screenClass: 'paymentsummarypage',
    screenName: 'resumendepagos',
  ),
  injections(
    screenClass: 'paymentsummarypage',
    screenName: 'injeccion',
  ),
  weekQuotas(
    screenClass: 'quotagrouppage',
    screenName: 'cuotasdelasemana',
  ),
  expiredQuotas(
    screenClass: 'quotagrouppage',
    screenName: 'cuotasvencidas',
  ),
  ;

  const ScreenEvents({
    required this.screenClass,
    required this.screenName,
  });

  final String screenClass;
  final String screenName;

}