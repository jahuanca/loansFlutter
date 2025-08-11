import 'package:get/get.dart';
import 'package:utils/utils.dart';

class NavigationContentController extends GetxController {

  int indexPage = defaultInt;
  
  void onChangedPage(int index) {
    indexPage = index;
    update([pageIdGet]);
  }
}