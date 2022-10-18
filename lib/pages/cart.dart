import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/models/product.dart';

import '../screens/widgets/product_qty_update.dart';

class Cart extends StatelessWidget {
  final bool isMain;
  const Cart({Key key, this.isMain = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      var item = products[i];
                      return CartItem(
                        item: item,
                        onRemoved: () {},
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: const Offset(0, 2),
                          blurRadius: 2.0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total",
                                    style: GoogleFonts.didactGothic(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "25000",
                                          style: GoogleFonts.anton(
                                            color: Colors.indigo[800],
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "CDF",
                                          style: GoogleFonts.didactGothic(
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Livraison",
                                    style: GoogleFonts.didactGothic(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "25000",
                                          style: GoogleFonts.anton(
                                            color: Colors.indigo,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "CDF",
                                          style: GoogleFonts.didactGothic(
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Net à payer",
                                    style: GoogleFonts.didactGothic(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "25000",
                                          style: GoogleFonts.anton(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "CDF",
                                          style: GoogleFonts.didactGothic(
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(15.0),
                                backgroundColor: Colors.green,
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
                                  color: Colors.white,
                                ),
                              ),
                              icon: const Icon(
                                CupertinoIcons.checkmark_alt_circle_fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //*Header la page *//
  Widget _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isMain) ...[
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              Text(
                "Panier",
                style: GoogleFonts.didactGothic(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  image: const DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/slider-1.jpeg"),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.5),
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {},
                    child: const Center(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Product item;
  final Function onRemoved;
  const CartItem({
    Key key,
    this.item,
    this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 90.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Image.asset(
                      item.imgPath,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.didactGothic(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "Livraison 2 jours",
                        style: GoogleFonts.didactGothic(
                          color: Colors.yellow[900],
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${item.price} ",
                                    style: GoogleFonts.anton(
                                      color: Colors.orange[800],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "CDF",
                                    style: GoogleFonts.didactGothic(
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PQtyUpdate(
                            onQuantityChanged: (int q) {
                              item.qty = q;
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.transparent,
              child: InkWell(
                onTap: onRemoved,
                borderRadius: BorderRadius.circular(30.0),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.clear,
                    size: 15.0,
                    color: Colors.pink,
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
