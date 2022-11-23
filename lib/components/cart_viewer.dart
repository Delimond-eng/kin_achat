import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:kinachat/db/repository.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

import '../global/controllers.dart';
import '../models/home_content.dart';
import '../screens/auth/authenticate.dart';
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
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[200],
      ),
      child: Obx(
        () => Column(
          children: [
            _header(context),
            Expanded(
              child: cartController.cartList.isEmpty
                  ? ZoomIn(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Lottie.asset(
                            "assets/lotties/empty-cart.json",
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeInUp(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10.0),
                              itemCount: cartController.cartList.length,
                              itemBuilder: (context, i) {
                                var item = cartController.cartList[i];
                                return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Icon(
                                        CupertinoIcons.clear,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red[300],
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      cartController.removeItemTocart(item);
                                    }
                                  },
                                  key: ObjectKey(item),
                                  child: CartItem(
                                    item: item,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            if (cartController.cartList.isNotEmpty) ...[
              ZoomIn(
                child: TicketDetail(
                  width: MediaQuery.of(context).size.width,
                  height: 170.0,
                  margin: const EdgeInsets.all(10),
                  color: secondaryColor,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      TicketItem(
                        title: "Sous total",
                        value: '\$ ${cartController.cartTotal.value}',
                      ),
                      const TicketItem(
                        title: "Frais livraison",
                        value: "\$2.00",
                      ),
                      const TicketItem(
                        title: "Taxe",
                        value: "\$ 0.00",
                      ),
                      DashedLine(
                        height: 2,
                        color: Colors.grey[200],
                      ),
                      TicketItem(
                        color: Colors.white,
                        title: "Total",
                        value: "\$ ${cartController.cartTotal.value + 2}",
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
            ]
          ],
        ),
      ),
    );
  }

  //*Header la page *//
  Widget _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: SafeArea(
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
                      if (cartController.cartList.isEmpty) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        Get.back();
                      }
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(CupertinoIcons.cart_fill, color: Colors.indigo[50]),
                  Positioned(
                    top: -10.0,
                    right: -5.0,
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
                        child: Text(
                          '${cartController.cartList.length}',
                          style: GoogleFonts.poppins(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.grey[200],
                          builder: (context) {
                            return const Authenticate();
                          },
                        );
                      },
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
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Produit item;
  const CartItem({
    Key key,
    this.item,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: OptimizedCacheImage(
                        height: 90.0,
                        width: 80.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        imageUrl: item.image,
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.filter_hdr_rounded),
                      ),
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
                        item.titre,
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
                                    text: "${item.prix} ",
                                    style: GoogleFonts.anton(
                                      color: Colors.orange[800],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.devise,
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
                            item: item,
                            onQuantityChanged: (int q) async {
                              homeController.selectedProduit.value.defaultQty =
                                  q;
                              InternalRepo.addItemToDbCart(item, q: q)
                                  .then((value) {
                                cartController.initCartTotal();
                              });
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
