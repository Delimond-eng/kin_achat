import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:kinachat/utils/dialogs/modals.dart';
import 'package:kinachat/utils/utils.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/social_btn.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _logo(),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  CupertinoIcons.clear,
                  size: 15.0,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                  ),
                  children: [
                    TextSpan(
                      text: "Connectez-vous",
                      style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: " ou ",
                    ),
                    TextSpan(
                      text: "cr??ez un compte",
                      style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: " en utilisant votre compte Google !",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SocialBtn(
                icon: "google_account",
                label: "Se connecter avec Google",
                onPressed: () => _signIn(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return Image.asset(
      "assets/logo.png",
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      fit: BoxFit.scaleDown,
    );
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      Xloading.showLottieLoading(context);
      await googleSignIn.signIn().then((value) => Xloading.dismiss());
      Get.back();
    } catch (error) {
      gPrint(error);
    }
  }
}
