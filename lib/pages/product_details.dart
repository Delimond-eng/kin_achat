import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/models/product.dart';
import '../widgets/line.dart';
import '../widgets/product_qty_update.dart';

import '../widgets/utilities_widget.dart';

class ProductSelectedDetails extends StatelessWidget {
  final Product data;
  const ProductSelectedDetails({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const CartViewer(),
      drawerScrimColor: Colors.black12,
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, key: _scaffoldKey),
          _detailImageSliders(context),
          _headerDetails(),
          const SizedBox(
            height: 10.0,
          ),
          _moreDetails(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.center,
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {},
                      label: Text(
                        "Ajouter au panier",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: const Icon(
                        CupertinoIcons.cart_badge_plus,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //*Affichage des détails du produits*//

  Widget _headerDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${data.price} ",
                      style: GoogleFonts.anton(
                        color: Colors.orange[800],
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    TextSpan(
                      text: "CDF",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const GLine(),
                      Text(
                        "Quantité",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const GLine(),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  PQtyUpdate(
                    onQuantityChanged: (int q) {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _moreDetails(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: Text(
                "Description",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur adipisicing elit  consectetur adipisicing elit.",
                style: GoogleFonts.didactGothic(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  child: Text(
                    "Vous preferez quelle couleur ?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => Container(
                        height: 30.0,
                        width: 30.0,
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: Colors
                              .primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .shade900,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color:
                                index == 0 ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  child: Text(
                    "Sélectionnez la taille",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => Container(
                        height: 50.0,
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.indigo[200],
                            width: .5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Center(
                            child: Text(
                              "XXL",
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: Text(
                "Autres Détails",
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  ...List.generate(
                    6,
                    (index) => _detailItem(context,
                        title: "detail $index  ",
                        value: "velit mollitia numquam nemo !"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //* Affichage carousel *//
  Widget _detailImageSliders(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);
    int _currentSlider = 0;
    return StatefulBuilder(
      builder: (context, setter) {
        return Column(
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo[200],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Hero(
                        tag: '${data.id}',
                        child: Image.asset(
                          data.imgPath,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setter(() {
                    _currentSlider = index;
                  });
                },
              ),
            ),
            _sliderIndicators(_currentSlider)
          ],
        );
      },
    );
  }

  //*Indicateur du carousel des images du produit cible*//
  Widget _sliderIndicators(int currentSlide) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) ...[
          if (i == currentSlide)
            const SlideDot(
              activeColor: Colors.indigo,
              isActived: true,
            )
          else
            const SlideDot(
              isActived: false,
            )
        ]
      ],
    );
  }

  //*Header la page *//
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
              "Détails",
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

  //*@[Widget] composant reutilisable pour afficher les détails clé-valeur*//
  Widget _detailItem(BuildContext context, {String title, String value}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey[300]),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title ",
            style: GoogleFonts.poppins(
              color: Colors.indigo,
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
