import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/app_main_header.dart';
import 'package:kinachat/components/costum_slider.dart';
import 'package:kinachat/components/products_list_viewer.dart';
import 'package:kinachat/screens/auth/auth.dart';
import 'package:kinachat/screens/auth/authenticate.dart';

import '../components/cart_viewer.dart';
import '../models/category.dart';
import '../models/product.dart';

import '../widgets/category_card.dart';
import '../widgets/filter_product_card.dart';
import 'product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //*scaffold _key state allow to open filter drawer *//
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: const CartViewer(),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppMainHeader(
            onOpenCart: () {
              _key.currentState.openEndDrawer();
            },
            onLoggedIn: () {
              // Get.to(
              //   const AuthScreen(),
              //   transition: Transition.circularReveal,
              //   duration: const Duration(milliseconds: 1000),
              // );
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return FadeInUp(
                      child: const Authenticate(),
                    );
                  });
            },
            onFiltered: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  _mainSlider(),
                  _categoriesPart(context),
                  _productsRecommanded(context),
                  _allProducts(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //*main slider *//
  Widget _mainSlider() => FadeInUp(child: const CostumSlider());

  //*Affichage du grid de tous les produits*//
  Widget _allProducts(BuildContext context) {
    return ProductsListViewer(
      dataList: products,
      isScrollable: false,
    );
  }

  //*Affichage des produits par filtrage*//
  Widget _productsRecommanded(BuildContext context) {
    //var _defaultSelection = "popular";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ZoomIn(
            child: Text(
              "Recommandations",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 10.0),
          child: Row(
            children: products
                .map((e) => FadeInLeftBig(
                      child: FilterProductCard(
                          data: e,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductSelectedDetails(
                                  data: e,
                                ),
                              ),
                            );
                          }),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
  //*End Filtering*//

  //*Affiche toutes les catégories de produits*//
  Widget _categoriesPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ZoomIn(
            child: Text(
              "Catégories",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            children: categories
                .map(
                  (e) => ZoomIn(
                    child: CategoryCard(
                      data: e,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
  //*End categories viewer *//

}
