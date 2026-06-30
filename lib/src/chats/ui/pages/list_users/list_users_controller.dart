
import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/chats/ui/pages/chat/chat_page.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class ListUsersController extends GetxController {

  GetUsersUseCase getUsersUseCase;
  List<UserEntity> users = [];

  ListUsersController({
    required this.getUsersUseCase,
  });

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  Future<void> getUsers() async {
    showLoading();
    Result<List<UserEntity>, ErrorEntity> result = await getUsersUseCase.execute();
    hideLoading();

    switch (result) {
      case Success():
        users = result.value;
        break;
      case Error():
        break;
    }
    update([pageIdGet]);
  }


  void goToChat() {
    Get.to(() => const ChatPage());
  }

}