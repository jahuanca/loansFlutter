import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils/utils.dart';

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
  } else if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    log(androidDeviceInfo.toString());
    return const AndroidId().getId();
  }
  return null;
}

Future<bool> isSupported() async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  return (canAuthenticateWithBiometrics || await auth.isDeviceSupported());
}

FutureOr<bool> setAllException(dynamic err) async {
  hideLoading();
  if (err is TimeoutException) {
    String message = '${err.message} ¿Desea volver a intentar?';
    bool result = await showDialogWidget(
      context: Get.context!,
      message: message,
      okText: 'Volver a intentar',
    );
    return result;
  }
  return false;
}

Result<T> executeResponseObject<T>({
  required Result<AppResponseHttp> response,
  required T Function(Map<String, dynamic>) convert,
}) {
  switch (response) {
    case Success():
      final value = response.value;
      if (response.value.isSuccessful) {
        return Result.success(convert(jsonDecode(value.body)));
      } else {
        final error = ErrorEntity(
          title: value.title,
          statusCode: value.statusCode,
          errorMessage: value.detail,
        );
        return Result.error(error);
      }
    case Error():
      return Result.error(response.error);
  }
}

Future<Result<List<T>>> executeResponseList<T>({
  required Result<AppResponseHttp> response,
  required List<T> Function(String) convert,
  String? sourceHiveDb,
}) async {
  switch (response) {
    case Success():
      final value = response.value;
      if (response.value.isSuccessful) {
        final data = convert(value.body);
        if (sourceHiveDb != null) {
          final box = await Hive.openBox(sourceHiveDb);
          await box.clear();
          await box.addAll(data.toList());
          await box.close();
        }

        return Result.success(data);
      } else {
        final error = ErrorEntity(
          title: value.title,
          statusCode: value.statusCode,
          errorMessage: value.detail,
        );
        return Result.error(error);
      }
    case Error():
      return Result.error(response.error);
  }
}

T? executeResultUI<T>(
  Result resultType,
) {
  switch (resultType) {
    case Success():
      return resultType.value;

    case Error():
      final error = resultType.error;
      if (error.statusCode == null) {
        showDialogWidget(context: Get.context!, message: error.title);
      } else {
        showSnackbarWidget(
            context: Get.context!,
            typeSnackbar: TypeSnackbar.error,
            message: error.errorMessage);
      }
      return null;
  }
}
