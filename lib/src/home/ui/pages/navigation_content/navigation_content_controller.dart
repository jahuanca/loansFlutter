import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loands_flutter/src/utils/ui/widgets/offline_bottom_sheet.dart';
import 'package:utils/utils.dart';

class NavigationContentController extends GetxController {
  int indexPage = defaultInt;
  InternetConnection connection = InternetConnection();

  @override
  void onInit() {
    connection.onStatusChange.listen(
      (event) {
        if (event == InternetStatus.disconnected) {
          showModalBottomSheet(
              context: Get.context!,
              builder: (context) => OfflineBottomSheet(status: event));
        }
      },
    );
    super.onInit();
  }

  void onChangedPage(int index) {
    indexPage = index;
    update([pageIdGet]);
  }
}