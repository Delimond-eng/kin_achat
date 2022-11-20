import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/models/product.dart';
import 'package:kinachat/utils/utils.dart';

import '../widgets/product_qty_update.dart';
import '../widgets/ticket.dart';

class CartViewer extends StatelessWidget {
  const CartViewer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      width: _size.width,
      margin: const EdgeInsets.fromLTRB(5, 40.0, 5, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FadeInUp(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        var item = products[i];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            child: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                CupertinoIcons.clear,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              gPrint("Dismissed");
                            }
                          },
                          key: ObjectKey(i),
                          child: CartItem(
                            item: item,
                            onRemoved: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ZoomIn(
            child: TicketDetail(
              width: MediaQuery.of(context).size.width,
              height: 170.0,
              margin: const EdgeInsets.all(10),
              color: Colors.indigo[400],
              isCornerRounded: true,
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const TicketItem(
                    title: "Sous total",
                    value: "\$ 25.05",
                  ),
                  const TicketItem(
                    title: "Frais livraison",
                    value: "\$2.00",
                  ),
                  const TicketItem(
                    title: "Total",
                    value: "\$27.05",
                  ),
                  DashedLine(
                    height: 2,
                    color: Colors.grey[500],
                  ),
                  const TicketItem(
                    color: Colors.white,
                    title: "Total",
                    value: "\$24.02",
                    fSize: 18.0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: FadeInLeft(
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    "Commander maintenant",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //*Header la page *//
  Widget _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
        ),
        color: Colors.indigo,
      ),
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
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Icon(CupertinoIcons.cart_fill, color: Colors.indigo[50]),
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
                    color: Colors.black.withOpacity(.2),
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
                        style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "Livraison 2 jours",
                        style: GoogleFonts.poppins(
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
                                    style: GoogleFonts.poppins(
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
      ],
    );
  }
}
