
import 'package:loands_flutter/src/settings/data/datastores/settings_datastore.dart';
import 'package:loands_flutter/src/settings/domain/repositories/settings_repository.dart';
import 'package:utils/utils.dart';

class SettingsRepositoryImplementation extends SettingsRepository {

  SettingsDatastore datastore;

  SettingsRepositoryImplementation(this.datastore);

  @override
  Future<Result<void, ErrorEntity>> updatePassword(String currentPassword, String newPassword) {
    return datastore.updatePassword(currentPassword, newPassword);
  }
}