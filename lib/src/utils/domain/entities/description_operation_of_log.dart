
enum DescriptionOperationOfLog {
  payQuota(title: 'PAY_QUOTA', detail: 'Quota pagada'), 
  createLoan(title: 'CREATE_LOAN', detail: 'Crédito nuevo'), 
  createSpecialLoan(title: 'CREATE_SPECIAL_LOAN', detail: 'Crédito nuevo'), 
  createCustomer(title: 'CREATE_CUSTOMER', detail: 'Cliente nuevo'),
  none(title: 'NONE', detail: 'Sin detalle');

  const DescriptionOperationOfLog({
    required this.title,
    required this.detail,
  });

  final String title;
  final String detail;
}