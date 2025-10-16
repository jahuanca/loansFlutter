
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_overlay.dart';

class LoadingService extends GetxService {

  OverlayEntry? _overlayEntry;
  bool isShowing = false;

  void show() {
    if (isShowing) return;

    isShowing = true;
    _overlayEntry = OverlayEntry(builder: (context) => const LoadingOverlay());
    final overlay = Navigator.of(Get.context!).overlay;
    if (_overlayEntry != null) {
      overlay?.insert(_overlayEntry!);
    }
  }

  void hide() {
    if (!isShowing) return;
    
    isShowing = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

void showLoading() => Get.find<LoadingService>().show();
void hideLoading() => Get.find<LoadingService>().hide();
bool isLoading() => Get.find<LoadingService>().isShowing;