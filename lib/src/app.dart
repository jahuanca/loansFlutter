import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_page.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_page.dart';
import 'package:loands_flutter/src/utils/core/local_preferences.dart';
import 'package:loands_flutter/src/utils/di/main_binding.dart';
import 'package:utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  Widget get _home {
    bool keepSesion = LocalPreferences().keepSesion();
    return (keepSesion) ? BackToSesionPage() : LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    MainBinding().dependencies();

    return GetMaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: const [Locale('es')],
      debugShowCheckedModeBanner: false,
      title: 'App de Pagos',
      home: _home,
    );
  }
}
