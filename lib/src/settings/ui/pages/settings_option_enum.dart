
enum SettingsOptionEnum {
  changeEmail(messageSuccess: 'Correo cambiado con éxito.'),
  changePassword(messageSuccess: 'Contraseña cambiada con éxito.');

  const SettingsOptionEnum({
    required this.messageSuccess,
  });

  final String messageSuccess;
}