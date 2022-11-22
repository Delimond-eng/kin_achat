import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/utils/colors.dart';

import '../global/controllers.dart';

class CartOpenningBtn extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isLight;
  const CartOpenningBtn({
    Key key,
    this.scaffoldKey,
    this.isLight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            color: isLight ? Colors.white : secondaryColor,
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
              onTap: () {
                scaffoldKey.currentState.openEndDrawer();
              },
              borderRadius: BorderRadius.circular(35.0),
              child: Center(
                child: Icon(
                  CupertinoIcons.shopping_cart,
                  size: 16.0,
                  color: isLight ? secondaryColor : Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -5.0,
          right: -2.0,
          child: ZoomIn(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Obx(
                () => Text(
                  '${cartController.cartList.length}',
                  style: GoogleFonts.poppins(
                    fontSize: 8.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
