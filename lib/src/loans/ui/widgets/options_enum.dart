
enum OptionsEnum {
  filter(id: 1, title: 'Filtrar'), 
  copy(id: 2, title: 'Copiar'), 
  setting(id: 3, title: 'Configurar'), 
  check(id: 4, title: 'Seleccionar');

  const OptionsEnum({
    required this.id, required this.title,
  });

  final int id;
  final String title;


}