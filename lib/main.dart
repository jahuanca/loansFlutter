import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/app.dart';
import 'package:loands_flutter/src/data_config.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/utils/ui/widgets/error/error_service.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPrefs();

  Get.put(LoadingService());
  Get.put(ErrorService());

  loadConfig(appConfig);

   Hive.registerAdapter(SummaryOfDashboardResponseAdapter());

  runApp(const App());
}
