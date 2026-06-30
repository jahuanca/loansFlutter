
import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/data/datastores/user_online_datastore.dart';
import 'package:loands_flutter/src/chats/data/repositories/user_repository_implementation.dart';
import 'package:loands_flutter/src/chats/domain/repositories/user_repository.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDatastore>(() => UserOnlineDatastore());

    Get.lazyPut<UserRepository>(
        () => UserRepositoryImplementation(Get.find())); 
    
    Get.lazyPut(() => GetUsersUseCase(Get.find()));
  }

}