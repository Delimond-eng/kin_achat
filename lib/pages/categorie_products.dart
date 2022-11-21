import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/models/home_content.dart';

import '../components/cart_viewer.dart';
import '../components/products_list_viewer.dart';
import '../global/controllers.dart';
import '../utils/utils.dart';

class CategorieProducts extends StatelessWidget {
  final Categorie data;
  const CategorieProducts({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const CartViewer(),
      drawerScrimColor: Colors.black12,
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _header(context, key: _scaffoldKey),
          Expanded(
            child: ProductsListViewer(
              dataList: homeController.categorieProduits,
              descriptionLabel: "Produits",
              isScrollable: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context, {key}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/svgs/back.svg",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              truncateString(data.categorie, length: 15),
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.heart,
                      size: 15.0,
                      color: Colors.orange[800],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(35.0),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        key.currentState.openEndDrawer();
                      },
                      borderRadius: BorderRadius.circular(35.0),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                          size: 15.0,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
