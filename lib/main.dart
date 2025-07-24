import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/app.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/config.dart';
import 'package:utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await UserPreferences().initPrefs();
  Get.put(LoadingService());

  loadConfig(DataConfig(
      showLog: false,
      authentication: EnumAuth.onlyToken,
      inputBorder: InputBorder.none,
      primaryColor: Colors.black,
      urlServer: serverUrl,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      wrapperWidgetInputs: (Widget child) => Card(
            elevation: 1,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          )));

  runApp(const App());
}
