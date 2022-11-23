import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/widgets/search_bar.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors.dart';
import '../widgets/cart_openning_btn.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> sKey = GlobalKey();

    return Scaffold(
      key: sKey,
      endDrawer: const CartViewer(),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _header(context, sKey),
          SearchBar(
            onChanged: (kWord) {},
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Lottie.asset("assets/lotties/search.json"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context, GlobalKey<ScaffoldState> sKey) {
    var size = MediaQuery.of(context).size;
    return Container(
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
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/svgs/back.svg",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Recherche...",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  CartOpenningBtn(
                    scaffoldKey: sKey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
