
import 'package:utils/utils.dart';

abstract class SettingsDatastore {
  Future<Result<void>> updatePassword(
    String currentPassword, String newPassword,
  );
}