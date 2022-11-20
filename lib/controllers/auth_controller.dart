import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<GoogleSignInAccount> currentUser;
  Rx<bool> userIsLoggedIn = false.obs;
}
