
enum TypeRenewalEnum {
  same(title: 'Igual', id: 'S'),
  increase(title: 'Aumento', id: 'I'),
  decrease(title: 'Disminuyo', id: 'D');

  const TypeRenewalEnum({
    required this.title,
    required this.id,
  });

  final String title;
  final String id;
}