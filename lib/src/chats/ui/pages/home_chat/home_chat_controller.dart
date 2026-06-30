import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:loands_flutter/src/chats/di/user_binding.dart';
import 'package:loands_flutter/src/chats/ui/pages/list_users/list_users_page.dart';
import 'package:utils/utils.dart';

class HomeChatController extends GetxController {
  late io.Socket socket;

  @override
  void onReady() {
    initSocket();
    super.onReady();
  }

  void goToListUsers() {
    Get.to(() => ListUsersPage(), binding: UserBinding());
  }

  Future<void> initSocket() async {
    socket = io.io(
      'http://10.0.2.2:3002',
      io.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
    socket.onConnect((_) {
      log('connect');
    });
    socket.emit('msg', 'test');

    socket.on('saludo', recieveMessage);
    socket.onDisconnect((_) => log('disconnect'));

    socket.onConnectError((error) {
      log('Error al conectar: $error');
    });

    socket.onError((error) {
      log('Error: $error');
    });
  }

  void recieveMessage (dynamic message) {
    showSnackbarWidget(context: Get.context!, typeSnackbar: TypeSnackbar.success, message: message);
  }

  @override
  void onClose() {
    socket.clearListeners();
    socket.disconnect();
    super.onClose();
  }
}
