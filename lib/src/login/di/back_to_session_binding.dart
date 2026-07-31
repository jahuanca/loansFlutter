
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/data/datastores/login_online_datastore.dart';
import 'package:loands_flutter/src/login/data/repositories/login_repository_implementation.dart';
import 'package:loands_flutter/src/login/data/datastores/login_datastore.dart';
import 'package:loands_flutter/src/login/domain/repositories/login_repository.dart';
import 'package:loands_flutter/src/login/domain/use_cases/login_use_case.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_controller.dart';

class BackToSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDatastore>(() => LoginOnlineDatastore());
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImplementation(datastore: Get.find()));
    Get.lazyPut(() => LoginUseCase(repository: Get.find()));
    Get.lazyPut(() => BackToSesionController(loginUseCase: Get.find()));
  }
}