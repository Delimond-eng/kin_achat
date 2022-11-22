import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:kinachat/utils/dialogs/modals.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';
import '../widgets/cart_openning_btn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> sKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: sKey,
      endDrawer: const CartViewer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          const SizedBox(
            height: 35.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    authController.currentUser.displayName.capitalizeFirst,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: GShape(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
              width: size.width,
              height: size.height * .20,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mon profil",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(35.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(35.0),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(35.0),
                                    onTap: _loggedOut,
                                    child: const Center(
                                      child: Icon(
                                        Icons.logout_rounded,
                                        color: Colors.black,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CartOpenningBtn(
                                scaffoldKey: sKey,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (authController.userIsLoggedIn.value == true) ...[
            Positioned(
              bottom: -40.0,
              left: 40.0,
              child: Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      offset: const Offset(0, 3),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: GoogleUserCircleAvatar(
                  identity: authController.currentUser,
                ),
              ),
            )
          ] else ...[
            Positioned(
              bottom: -40.0,
              left: 40.0,
              child: Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      offset: const Offset(0, 3),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Lottie.asset("assets/lotties/login.json"),
                  ),
                ),
              ),
            )
          ]
        ],
      );
    });
  }

  Future<void> _loggedOut() async {
    XDialog.show(context,
        message: "Etes-vous sûr de vouloir vous déconnecter de votre compte ??",
        onValidated: () async {
      await googleSignIn.disconnect();
    });
  }
}

class GShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
      Rect.fromCircle(
        center: Offset(
          size.width * .22,
          size.height,
        ),
        radius: 50.0,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
