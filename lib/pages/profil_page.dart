import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [_header(context)],
      ),
    );
  }

  Stack _header(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: GShape(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.indigo[300],
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Mon profil",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
      ],
    );
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
