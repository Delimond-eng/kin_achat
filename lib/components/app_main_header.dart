import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors.dart';
import '../widgets/cart_openning_btn.dart';

class AppMainHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState> sKey;
  final Function onLoggedIn;
  final Function onSearched;
  const AppMainHeader({Key key, this.onLoggedIn, this.sKey, this.onSearched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _logo(),
                  Obx(() {
                    return Row(
                      children: [
                        Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(35.0),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: onSearched,
                              borderRadius: BorderRadius.circular(35.0),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.search,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        CartOpenningBtn(
                          scaffoldKey: sKey,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
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
                      ],
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox(
          height: 50.0,
          width: 50.0,
        ),
        Positioned(
          top: -5,
          left: 0,
          child: Image.asset(
            "assets/logo.png",
            height: 55.0,
            width: 55.0,
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
          ),
        )
      ],
    );
  }
}
