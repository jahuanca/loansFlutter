
import 'package:utils/utils.dart';

abstract class SettingsRepository {
  Future<Result<void>> updatePassword(
    String lastPassword, String newPassword,
  );
}