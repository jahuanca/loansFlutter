import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/ui/pages/home_settings/home_settings_controller.dart';
import 'package:loands_flutter/src/settings/ui/pages/home_settings/home_settings_enum.dart';
import 'package:utils/utils.dart';

class HomeSettingsPage extends StatelessWidget {

  final HomeSettingsController controller = HomeSettingsController();
  
  HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSettingsController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Ajustes'),
        body: _body()
      ),
    );
  }

  Widget _body() {

    final items = HomeSettingsEnum.values.map(
      (e) => ListTile(
        leading: Icon(e.icon),
        title: Text(e.title),
        onTap: () => controller.goToEventEnum(e),
      ),
    ).toList();

    return Column(children: items);
  }
}
