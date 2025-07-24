
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/data/datastores/login_online_datastore.dart';
import 'package:loands_flutter/src/login/data/repositories/login_repository_implementation.dart';
import 'package:loands_flutter/src/login/domain/datastores/login_datastore.dart';
import 'package:loands_flutter/src/login/domain/repositories/login_repository.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDatastore>(() => LoginOnlineDatastore());
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => LoginUseCase(repository: Get.find()));
  }
}