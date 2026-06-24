
import 'package:utils/utils.dart';

abstract class SettingsRepository {
  Future<Result<void, ErrorEntity>> updatePassword(
    String lastPassword, String newPassword,
  );
}