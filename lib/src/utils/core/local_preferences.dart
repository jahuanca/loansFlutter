import 'package:utils/utils.dart';

const String keepSesionKey = 'keepSesionKey';
const String emailKey = 'emailKey';
const String isOfflineKey = 'isOfflineKey';

class LocalPreferences {
  bool keepSesion() => UserPreferences().getBool(keepSesionKey);

  Future<void> setKeepSesion(bool value) =>
      UserPreferences().setBool(keepSesionKey, value);

  bool isOffLine() => UserPreferences().getBool(isOfflineKey); 

  Future<void> setisOffline(bool value) =>
      UserPreferences().setBool(isOfflineKey, value);

  String? email() => UserPreferences().getString(emailKey);

  Future<void> setEmail(String value) =>
      UserPreferences().setString(emailKey, value);
}
