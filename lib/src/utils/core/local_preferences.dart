import 'package:utils/utils.dart';

const String keepSesionKey = 'keepSesionKey';
const String emailKey = 'emailKey';

class LocalPreferences {

  bool keepSesion() => UserPreferences().getBool(keepSesionKey);

  Future<void> setKeepSesion(bool value) =>
      UserPreferences().setBool(keepSesionKey, value);

  String? email() => UserPreferences().getString(emailKey);

  Future<void> setEmail(String value) =>
      UserPreferences().setString(emailKey, value);
}
