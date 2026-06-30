import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/ui/pages/home_settings/home_settings_controller.dart';
import 'package:utils/utils.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSettingsController>(
      init: HomeSettingsController(),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Ajustes'),
        body: Column(
          children: [
            const ListTile(  
              leading: Icon(Icons.email_outlined),
              title: Text('Cambiar correo'),
            ),
            ListTile(  
              onTap: controller.goToUpdatePassword,
              leading: const Icon(Icons.password),
              title: const Text('Cambiar contraseña'),
            ),
            ListTile(
              onTap: controller.goVideo,
              leading: const Icon(Icons.video_camera_front_outlined),
              title: const Text('Ver tutorial'),
            ),
            ListTile(
              onTap: controller.goChats,
              leading: const Icon(Icons.chat_outlined),
              title: const Text('Chat'),
            ),
            ListTile(
              onTap: controller.goLogout,
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
