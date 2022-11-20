import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
  ],
);

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  GoogleSignInAccount currentUser;

  var userIsLoggedIn = false.obs;
  @override
  void onInit() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      currentUser = account;
      if (account != null) {
        userIsLoggedIn.value = true;
      } else {
        userIsLoggedIn.value = false;
      }
    });
    googleSignIn.signInSilently();
    super.onInit();
  }
}
