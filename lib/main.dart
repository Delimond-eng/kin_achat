import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kinachat/controllers/auth_controller.dart';
import 'package:kinachat/controllers/cart_controller.dart';
import 'controllers/home_controller.dart';
import 'db/db.dart';
import 'screens/starter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Builder(
        builder: (context) {
          return const Starter();
        },
      ),
    );
  }
}
