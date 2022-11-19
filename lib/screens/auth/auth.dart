import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:lottie/lottie.dart';
import '../../utils/utils.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>['email'],
);

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      gPrint(account);
    });
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo[900],
              Colors.indigo[900],
              Colors.indigo[400],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: AuthCard(),
                  child: Container(
                    width: size.width,
                    height: size.height * .35,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _logo(),
                        SocialBtn(
                          icon: "google_account",
                          label: "Se connecter avec Google",
                          onPressed: _signIn,
                        ),
                        const SocialBtn(
                          icon: "facebook_account",
                          label: "Se connecter avec Facebook",
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -50.0,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(90.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 3),
                          blurRadius: 10,
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
              ],
            )
          ],
        ),
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.staatliches(
              color: Colors.indigo,
              fontSize: 35.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            children: [
              const TextSpan(
                text: "Kin",
              ),
              TextSpan(
                text: " Achat",
                style: GoogleFonts.staatliches(
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      gPrint(error);
    }
  }

  Future<void> logOut() => googleSignIn.disconnect();
}

class SocialBtn extends StatelessWidget {
  final String label;
  final String icon;
  final Function onPressed;
  const SocialBtn({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: const Offset(0, 2),
            blurRadius: 2,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svgs/$icon.svg",
                  height: 30.0,
                  width: 30.0,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthCard extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(
        center: Offset(
          size.width / 2,
          0.0,
        ),
        radius: 60.0));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
