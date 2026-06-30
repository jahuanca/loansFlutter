import 'package:utils/utils.dart';

const String keepSesionKey = 'keepSesionKey';

class LocalPreferences {
  bool keepSesion() => UserPreferences().getBool(keepSesionKey);

  Future<void> setKeepSesion(bool value) =>
      UserPreferences().setBool(keepSesionKey, value);
}
