import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import '../components/products_list_viewer.dart';
import '../db/repository.dart';
import '../models/home_content.dart';
import '../widgets/cart_openning_btn.dart';
import '../widgets/line.dart';
import '../widgets/product_qty_update.dart';

import '../widgets/utilities_widget.dart';

class ProductSelectedDetails extends StatelessWidget {
  final bool isFavorite;
  const ProductSelectedDetails({Key key, this.isFavorite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const CartViewer(),
      drawerScrimColor: Colors.black12,
      backgroundColor: Colors.grey[200],
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, key: _scaffoldKey),
            _detailImageSliders(context),
            _headerDetails(),
            const SizedBox(
              height: 5.0,
            ),
            _moreDetails(context, _scaffoldKey),
          ],
        ),
      ),
    );
  }

  //*Affichage des détails du produits*//

  Widget _headerDetails() {
    Produit product = homeController.selectedProduit.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  product.titre.toLowerCase().capitalizeFirst,
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
                      text: "${product.prix} ",
                      style: GoogleFonts.anton(
                        color: Colors.orange[800],
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    TextSpan(
                      text: product.devise,
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
                    onQuantityChanged: (int q) {
                      homeController.selectedProduit.value.defaultQty = q;
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

  Widget _moreDetails(BuildContext context, GlobalKey<ScaffoldState> sKey) {
    Produit product = homeController.selectedProduit.value;
    var detail =
        homeController.selectedProduitDetails.value.reponse.produitDetails;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: FadeInUp(
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
                  product.description.isEmpty
                      ? 'Aucune description !'
                      : product.description.toLowerCase().capitalizeFirst,
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
                              color: index == 0
                                  ? Colors.white
                                  : Colors.transparent,
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
              if (detail.details.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
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
                      ...detail.details
                          .map(
                            (e) => _detailItem(
                              context,
                              title: e.sousCategorieDetail,
                              value: e.produitDetail,
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ],
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
                            padding: const EdgeInsets.all(15.0),
                            alignment: Alignment.center,
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            InternalRepo.addItemToDbCart(product,
                                    q: product.defaultQty)
                                .then((_) {
                              cartController.initCartTotal();
                              sKey.currentState.openEndDrawer();
                            });
                          },
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
              ),
              ProductsListViewer(
                dataList: homeController
                    .selectedProduitDetails.value.reponse.recommandations,
                isScrollable: false,
                descriptionLabel: "Produits similaires",
                isDataDetail: true,
                isListFirst: true,
              )
            ],
          ),
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
        var medias = homeController
            .selectedProduitDetails.value.reponse.produitDetails.images;
        return Column(
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: medias.length,
                itemBuilder: (context, index) {
                  var img = medias[index];
                  return ZoomIn(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo[200],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: OptimizedCacheImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 200.0,
                            imageUrl: img.media,
                            placeholder: (context, url) => const SizedBox(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.filter_hdr_rounded),
                          ),
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
            _sliderIndicators(
              _currentSlider,
              length: medias.length,
            )
          ],
        );
      },
    );
  }

  //*Indicateur du carousel des images du produit cible*//
  Widget _sliderIndicators(int currentSlide, {int length = 3}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < length; i++) ...[
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
    bool isLiked = isFavorite;
    Produit product = homeController.selectedProduit.value;
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
                StatefulBuilder(builder: (context, setter) {
                  return Container(
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
                        borderRadius: BorderRadius.circular(35.0),
                        onTap: () async {
                          InternalRepo.insertFavorite(product).then((s) {
                            if (s == product.produitId) {
                              setter(() => isLiked = true);
                            }
                            if (s.isEmpty) {
                              setter(() => isLiked = false);
                            }
                          });
                        },
                        child: Center(
                          child: Icon(
                            isLiked
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            size: 15.0,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  width: 8.0,
                ),
                CartOpenningBtn(
                  scaffoldKey: key,
                  isLight: false,
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
              value.isEmpty ? 'non spécifié' : value,
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
