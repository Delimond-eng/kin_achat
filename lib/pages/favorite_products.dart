import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/db/repository.dart';
import 'package:kinachat/models/home_content.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:lottie/lottie.dart';

import '../components/products_list_viewer.dart';
import '../widgets/cart_openning_btn.dart';
import '../widgets/product_grid_card.dart';

class FavoriteProducts extends StatefulWidget {
  const FavoriteProducts({Key key}) : super(key: key);

  @override
  State<FavoriteProducts> createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  void refreshDatas() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      backgroundColor: Colors.grey[200],
      endDrawer: const CartViewer(),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: _favoriteProducts(context),
          )
        ],
      ),
    );
  }

  Widget _favoriteProducts(BuildContext context) {
    return FutureBuilder<List<Produit>>(
      future: InternalRepo.getFavorites(),
      builder: ((context, snapshot) {
        if (snapshot.data == null) {
          return FadeInUp(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .6,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 6,
              itemBuilder: ((context, index) {
                return ZoomIn(
                  child: const GridProductCardPlaceholder(),
                );
              }),
            ),
          );
        }
        if (snapshot.data.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Lottie.asset("assets/lotties/empty-0.json"),
            ),
          );
        }
        return ProductsListViewer(
          dataList: snapshot.data,
          isScrollable: true,
          isListFirst: snapshot.data.length < 4,
          descriptionLabel: "Produits favoris",
        );
      }),
    );
  }

  Widget _header(BuildContext context) {
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
                  Text(
                    "Mes favoris",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CartOpenningBtn(
                    scaffoldKey: _sKey,
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
