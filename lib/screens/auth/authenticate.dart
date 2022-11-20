import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/social_btn.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
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
                  style: GoogleFonts.didactGothic(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  children: [
                    TextSpan(
                      text: "Connectez-vous",
                      style: GoogleFonts.poppins(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                    const TextSpan(
                      text: " ou ",
                    ),
                    TextSpan(
                      text: "créez un compte",
                      style: GoogleFonts.poppins(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                    const TextSpan(
                      text: " en utilisant votre compte Google !",
                    ),
                  ],
                ),
              ),
              SocialBtn(
                icon: "google_account",
                label: "Se connecter avec Google",
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.didactGothic(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              children: [
                const TextSpan(
                  text: "Besoin ",
                ),
                TextSpan(
                  text: "d'aide ?",
                  style: GoogleFonts.poppins(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
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
}
