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
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700,
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
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.staatliches(
            color: Colors.indigo,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
          children: [
            const TextSpan(
              text: "Kin",
            ),
            TextSpan(
              text: " Achat",
              style: GoogleFonts.staatliches(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
