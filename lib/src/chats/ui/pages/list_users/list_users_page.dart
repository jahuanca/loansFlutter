import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/ui/pages/list_users/list_users_controller.dart';
import 'package:utils/utils.dart';

class ListUsersPage extends StatelessWidget {
  final ListUsersController controller = ListUsersController(
    getUsersUseCase: Get.find(),
  );

  ListUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUsersController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Nuevo chat'),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    final items = controller.users;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _item(items[index]),
    );
  }

  Widget _item(UserEntity user) {
    return ListTile(
      leading: const IconWidget(iconData: Icons.people),
      title: Text(user.fullName),
      onTap: controller.goToChat,
    );
  }
}
