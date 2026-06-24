
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/data/datastores/settings_datastore.dart';
import 'package:loands_flutter/src/settings/data/datastores/settings_online_datastore.dart';
import 'package:loands_flutter/src/settings/data/repositories/settings_repository_implementation.dart';
import 'package:loands_flutter/src/settings/domain/repositories/settings_repository.dart';
import 'package:loands_flutter/src/settings/domain/use_cases/update_password_use_case.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsDatastore>(() => SettingsOnlineDatastore());
    Get.lazyPut<SettingsRepository>(() => SettingsRepositoryImplementation(Get.find()));
    Get.lazyPut(() => UpdatePasswordUseCase(Get.find()));
  }
}