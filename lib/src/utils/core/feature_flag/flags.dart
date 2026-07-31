
const String createLoanDashboardFlag = 'createLoanDashboard';

enum Documents {
  createLoan,
  login,
}

enum Flag {
  createLoanDashboard(
    code: createLoanDashboardFlag,
    document: Documents.createLoan,
  ),
  mainLogin(
    code: 'mainLogin',
    document: Documents.login,
  ),
  secondLogin(
    code: 'secondLogin',
    document: Documents.login,
  );

  const Flag({
    required this.code,
    required this.document,
  });

  final String code;
  final Documents document;

}