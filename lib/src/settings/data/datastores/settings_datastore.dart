
import 'package:utils/utils.dart';

abstract class SettingsDatastore {
  Future<Result<void, ErrorEntity>> updatePassword(
    String currentPassword, String newPassword,
  );
}