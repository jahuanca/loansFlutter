import 'dart:io';

import 'package:get/get.dart';
import 'package:loands_flutter/src/utils/core/config.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;

  @override
  void onInit() {
    videoController = VideoPlayerController.networkUrl(
      Uri.parse('$serverUrl/video'),
      httpHeaders: {
        HttpHeaders.authorizationHeader: UserPreferences().getToken() ?? '',
      },
    )..initialize().then((_) {
        update();
      });
    super.onInit();
  }

  Future<void> onPressed() async {
    if (videoController.value.isPlaying) {
      await videoController.pause();
    } else {
      await videoController.play();
    }
    update();
  }

  Future<void> nextTo() async {
    Duration position = videoController.value.position;
    showLoading();
    await videoController.seekTo(position + const Duration(seconds: 60));
    hideLoading();
    update();
  }

  Future<void> backTo() async {
    Duration position = videoController.value.position;
    showLoading();
    await videoController.seekTo(position + const Duration(seconds: -30));
    hideLoading();
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }

}
