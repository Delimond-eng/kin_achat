import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:kinachat/utils/dialogs/modals.dart';
import 'package:kinachat/widgets/input_text.dart';
import 'package:kinachat/widgets/ticket.dart';
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
      drawer: const AdresseAddDrawer(),
      drawerScrimColor: Colors.black12,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        authController.currentUser.displayName.capitalizeFirst,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.envelope,
                            color: secondaryColor,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            authController.currentUser.email,
                            style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _titleSection(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Lottie.asset(
                        "assets/lotties/address.json",
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInRight(
                child: Text(
                  "Mes adresses",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
              ),
              FadeInLeft(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
                  ),
                  onPressed: () {
                    sKey.currentState.openDrawer();
                  },
                  icon: const Icon(
                    CupertinoIcons.add,
                    size: 15.0,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Ajouter",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Veuillez configurer vos adresses de livraison pour permettre à nos livreurs de vous retrouver facilement en cas d'une commande en cours!",
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          DashedLine(
            color: secondaryColor.withOpacity(.4),
            height: 2,
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

class AdresseAddDrawer extends StatelessWidget {
  const AdresseAddDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var no = TextEditingController();
    var av = TextEditingController();
    var qa = TextEditingController();
    var co = TextEditingController();
    var ref = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(
          8, MediaQuery.of(context).size.height * .18, 8, 8),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(
                "assets/lotties/address.json",
                height: 40.0,
                width: 40.0,
                fit: BoxFit.scaleDown,
              ),
              IconButton(
                iconSize: 18.0,
                color: Colors.grey,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.clear,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: InputField(
                          filledColor: Colors.grey[200],
                          icon: CupertinoIcons.location_solid,
                          title: "Numéro",
                          hintText: "NO.",
                          controller: no,
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: InputField(
                          filledColor: Colors.grey[200],
                          icon: CupertinoIcons.location_solid,
                          title: "Avenue",
                          hintText: "Av.",
                          controller: av,
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    filledColor: Colors.grey[200],
                    icon: CupertinoIcons.location_solid,
                    title: "Quartier",
                    hintText: "Entrer quartier...",
                    controller: qa,
                  ),
                  InputField(
                    filledColor: Colors.grey[200],
                    icon: CupertinoIcons.location_solid,
                    title: "Commune",
                    hintText: "Entrer commune...",
                    controller: co,
                  ),
                  InputField(
                    filledColor: Colors.grey[200],
                    icon: CupertinoIcons.location_solid,
                    title: "Référence",
                    hintText: "Entrer réf...",
                    controller: ref,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Enregistrer",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
