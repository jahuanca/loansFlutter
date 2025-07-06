
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class NavigationContentController extends GetxController {

  int indexPage = defaultInt;
  
  final PageController pageController = PageController();

  void onChangedPage(int index) {
    indexPage = index;
    pageController.jumpToPage(indexPage);
    update([pageIdGet]);
  }
}