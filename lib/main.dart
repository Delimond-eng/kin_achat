import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kinachat/controllers/auth_controller.dart';
import 'package:kinachat/controllers/cart_controller.dart';
import 'package:kinachat/screens/splash_screen.dart';
import 'package:kinachat/utils/colors.dart';
import 'controllers/home_controller.dart';
import 'db/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await DB.initDb();
  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'kin achat app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: secondaryColor),
      home: Builder(
        builder: (context) {
          return const SplashScreen();
        },
      ),
    );
  }
}
