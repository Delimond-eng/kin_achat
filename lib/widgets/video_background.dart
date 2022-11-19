import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBg extends StatefulWidget {
  const VideoBg({Key key}) : super(key: key);

  @override
  State<VideoBg> createState() => _VideoBgState();
}

class _VideoBgState extends State<VideoBg> {
  VideoPlayerController vController;

  @override
  void initState() {
    super.initState();
    vController = VideoPlayerController.asset("assets/videos/video_10.mp4")
      ..initialize().then(
        (_) {
          vController.setVolume(0.0);
          vController.play();
          vController.setLooping(true);
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    vController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: vController.value.isInitialized
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                        child: VideoPlayer(vController),
                        width: constraints.maxWidth *
                            vController.value.aspectRatio,
                        height: constraints.maxHeight),
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
