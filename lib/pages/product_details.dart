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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          data.title,
                          style: GoogleFonts.didactGothic(
                            color: Colors.indigo,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
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
                      PQtyUpdate(
                        onQuantityChanged: (int q) {
                          debugPrint('$q');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}
