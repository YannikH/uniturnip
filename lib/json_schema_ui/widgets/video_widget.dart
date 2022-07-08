import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () =>
    controller.value.isPlaying ? controller.pause() : controller.play(),
    child: Stack(
      children: <Widget>[
        buildPlay(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: buildIndicator(),
        ),
      ],
    ),
  );

  Widget buildIndicator() => VideoProgressIndicator(
    controller,
    allowScrubbing: true,
  );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
    alignment: Alignment.center,
    color: Colors.black26,
    child: const Icon(Icons.play_arrow, color: Colors.white, size: 80),
  );
}



class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(
            height: 200,
            child: const Center(child: CircularProgressIndicator()),
          );

  Widget buildVideo() => Stack(
    children: <Widget>[
      buildVideoPlayer(),
      Positioned.fill(child: BasicOverlayWidget(controller: controller)),
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  );
}

class NetworkPlayerWidget extends StatefulWidget {
  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  // final textController = TextEditingController(text: urlLandscapeVideo);
  VideoPlayerController? controller;
  WidgetData? widgetData;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widgetData!.uiSchema['video'])
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Container(
        alignment: Alignment.center,
        child: VideoPlayerWidget(
            controller: controller as VideoPlayerController),
      );
}