import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:lottie/lottie.dart';

import '../widgets/cart_openning_btn.dart';
import '../widgets/search_bar.dart';

class AppMainHeader extends StatelessWidget {
  final Function onFiltered;
  final GlobalKey<ScaffoldState> sKey;
  final Function onLoggedIn;
  const AppMainHeader({Key key, this.onFiltered, this.onLoggedIn, this.sKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _logo(),
                  Obx(() {
                    return Row(
                      children: [
                        if (authController.userIsLoggedIn.value == true) ...[
                          SizedBox(
                            height: 35.0,
                            width: 35.0,
                            child: GoogleUserCircleAvatar(
                              identity: authController.currentUser,
                            ),
                          ),
                        ] else ...[
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
                                onTap: onLoggedIn,
                                child: Center(
                                  child: Lottie.asset(
                                    "assets/lotties/login.json",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(
                          width: 10.0,
                        ),
                        CartOpenningBtn(
                          scaffoldKey: sKey,
                        )
                      ],
                    );
                  })
                ],
              ),
              const SizedBox(height: 10.0),
              SearchBar(
                onFiltered: onFiltered,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.staatliches(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
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
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
