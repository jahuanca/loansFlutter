
enum TypeRenewalEnum {
  same(title: 'Igual'),
  increase(title: 'Aumento'),
  decrease(title: 'Disminuyo');

  const TypeRenewalEnum({
    required this.title,
  });

  final String title;
}