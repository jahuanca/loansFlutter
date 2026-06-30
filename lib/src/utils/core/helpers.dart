
import 'dart:developer';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> sendingSMS(String phoneNumber) async {
      Uri url = Uri(
        scheme: 'sms',
        path: '+51$phoneNumber',
      );
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
      }
}

Future<void> calling(String phoneNumber) async {
      Uri url = Uri(
        scheme: 'tel',
        path: "+51$phoneNumber",
      );
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
      }
}

Future<String?> getAndroidId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if(Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    log(androidDeviceInfo.toString());
    return const AndroidId().getId();
  }
  return null;
}