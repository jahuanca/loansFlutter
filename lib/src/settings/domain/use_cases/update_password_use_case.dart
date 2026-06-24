
import 'package:loands_flutter/src/settings/domain/repositories/settings_repository.dart';
import 'package:utils/utils.dart';

class UpdatePasswordUseCase {
  SettingsRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<Result<void, ErrorEntity>> execute(
    String lastPassword, String newPassword,
  ) {
    return repository.updatePassword(lastPassword, newPassword);
  }

}