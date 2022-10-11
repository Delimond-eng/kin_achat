import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  VideoPlayerController vController;

  @override
  void initState() {
    super.initState();
    vController = VideoPlayerController.asset("assets/videos/video_5.mp4")
      ..initialize().then(
        (_) {
          vController.play();
          vController.setVolume(0.0);
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(.6),
            ),
          )
        ],
      ),
    );
  }
}
