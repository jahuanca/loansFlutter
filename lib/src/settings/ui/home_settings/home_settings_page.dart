import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/ui/home_settings/home_settings_controller.dart';
import 'package:utils/utils.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSettingsController>(
      init: HomeSettingsController(),
      builder: (controller)=> Scaffold(
        appBar: appBarWidget(text: 'Ajustes'),
        body: Column(
          children: [
            ListTile(
              onTap: controller.logout,
              title: const Text('Cerrar sesión'),
            )
          ],
        ),
      ),
    );
  }
}