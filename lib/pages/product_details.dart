import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/models/product.dart';
import 'package:kinachat/screens/widgets/product_qty_update.dart';

import '../screens/widgets/utilities_widget.dart';

class ProductSelectedDetails extends StatelessWidget {
  final Product data;
  const ProductSelectedDetails({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
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
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.indigo[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () {},
                    label: Text(
                      "Commander",
                      style: GoogleFonts.didactGothic(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.0,
                        color: Colors.indigo[800],
                      ),
                    ),
                    icon: Icon(
                      CupertinoIcons.bag,
                      color: Colors.indigo[800],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
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
                        "Panier",
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                        ),
                      ),
                      icon: const Icon(
                        CupertinoIcons.shopping_cart,
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
                      style: GoogleFonts.didactGothic(
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
                      _line(),
                      Text(
                        "Quantité",
                        style: GoogleFonts.didactGothic(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      _line()
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  PQtyUpdate(
                    onQuantityChanged: (int q) {
                      debugPrint('$q');
                    },
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
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: GoogleFonts.didactGothic(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              "Lorem ipsum dolor sit amet consectetur adipisicing elit  consectetur adipisicing elit.",
              style: GoogleFonts.didactGothic(
                color: Colors.black54,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Autres Détails",
              style: GoogleFonts.didactGothic(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            ...List.generate(
              6,
              (index) => _detailItem(context,
                  title: "detail $index  ",
                  value: "velit mollitia numquam nemo !"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 2,
      width: 12.0,
      color: Colors.black,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
  Widget _header(BuildContext context) {
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
              style: GoogleFonts.didactGothic(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.heart,
                      size: 15.0,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.shopping_cart,
                      size: 15.0,
                      color: Colors.orange,
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
            style: GoogleFonts.didactGothic(
              color: Colors.indigo,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.didactGothic(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
