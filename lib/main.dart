import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loands_flutter/firebase_options.dart';
import 'package:loands_flutter/src/app.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/data_config.dart';
import 'package:loands_flutter/src/home/data/responses/summary_of_dashboard_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/analytics/analytics_service.dart';
import 'package:loands_flutter/src/utils/core/feature_flag/feature_flag_service.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/ui/widgets/error/error_service.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPrefs();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(LoadingService());
  Get.put(FeatureFlagService());
  Get.put(AnalyticsService());
  Get.put(ErrorService());

  loadConfig(appConfig);
  await Hive.initFlutter();
  Hive.registerAdapter(SummaryOfDashboardResponseAdapter());
  Hive.registerAdapter(LoanEntityAdapter());
  Hive.registerAdapter(CustomerEntityAdapter());
  Hive.registerAdapter(PaymentFrequencyEntityAdapter());
  Hive.registerAdapter(PaymentMethodEntityAdapter());

  runApp(const App());
}
