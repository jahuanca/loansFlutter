import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loands_flutter/src/chats/ui/pages/home_chat/home_chat_controller.dart';
import 'package:utils/utils.dart';

class HomeChatPage extends StatelessWidget {

  final HomeChatController controller = HomeChatController();

  HomeChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeChatController>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Chat'),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goToListUsers,
          child: const Icon(Icons.add),
          ),
      ),
    );
  }
}