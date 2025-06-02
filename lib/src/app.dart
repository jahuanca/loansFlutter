import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_page.dart';
import 'package:loands_flutter/src/utils/di/main_binding.dart';
import 'package:utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: const [Locale('es')],
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const DashboardPage(),
      initialBinding: MainBinding(),
    );
  }
}
