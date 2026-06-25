import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loands_flutter/src/utils/ui/pages/video_player/video_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        init: VideoController(),
        builder: (controller) => Scaffold(
              body: Center(
                child: controller.videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            controller.videoController.value.aspectRatio,
                        child: VideoPlayer(controller.videoController),
                      )
                    : Container(),
              ),
              floatingActionButton: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'play',
                    onPressed: controller.onPressed,
                    child: Icon(
                      controller.videoController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'plus',
                    onPressed: controller.nextTo,
                    child: const Icon(
                      Icons.plus_one,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'minus',
                    onPressed: controller.backTo,
                    child: const Icon(
                      Icons.minimize,
                    ),
                  ),
                ],
              ),
            ));
  }
}
