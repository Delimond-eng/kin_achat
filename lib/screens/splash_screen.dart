import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kinachat/global/local_data.dart';
import 'package:kinachat/screens/public/home_screen.dart';
import 'package:kinachat/screens/starter.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    Future.delayed(const Duration(seconds: 3), () {
      if (storage.read("using") == null) {
        Navigator.pushAndRemoveUntil(
            _globalKey.currentContext,
            MaterialPageRoute(builder: (context) => const Starter()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            _globalKey.currentContext,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ZoomIn(
            child: Image.asset(
              "assets/logo.png",
              height: 150.0,
              width: 150.0,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
