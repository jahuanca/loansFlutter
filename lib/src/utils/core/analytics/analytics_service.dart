import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:loands_flutter/src/utils/core/analytics/screen_events.dart';
import 'package:utils/utils.dart';

class AnalyticsService extends GetxService {

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> trackEvent(String event) async {
    await analytics.logEvent(name: event);
  }

  Future<void> screenEvent(ScreenEvents event) async {
    await analytics.logScreenView(screenClass: event.screenClass, screenName: event.screenName);
  }

  Future<void> trackRenewal(double amount) async {
    await analytics.logEvent(
      name: 'renewalloan',
      parameters: {
        'amount': amount.formatDecimals(),
      }
    );
  }
}

Future<void> trackEvent(String event) => Get.find<AnalyticsService>().trackEvent(event);
Future<void> screenEvent(ScreenEvents event) => Get.find<AnalyticsService>().screenEvent(event);
Future<void> trackRenewal(double amount) => Get.find<AnalyticsService>().trackRenewal(amount);