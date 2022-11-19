import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/app_main_header.dart';
import 'package:kinachat/components/products_list_viewer.dart';
import 'package:kinachat/screens/auth/auth.dart';

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
              Get.to(
                const AuthScreen(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 1000),
              );
            },
            onFiltered: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    margin: const EdgeInsets.fromLTRB(10, 15.0, 10.0, 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                        )
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/slider-2.jpeg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  _categoriesPart(context),
                  _productsFiltering(context),
                  _allProducts(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //*Affichage du grid de tous les produits*//
  Widget _allProducts(BuildContext context) {
    return ProductsListViewer(
      dataList: products,
      isScrollable: false,
    );
  }

  //*Affichage des produits par filtrage*//
  Widget _productsFiltering(BuildContext context) {
    //var _defaultSelection = "popular";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   padding:
        //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        //   child: Row(
        //     children: _filters
        //         .map(
        //           (e) => FilterBtn(
        //             label: e['label'],
        //             isSelected: e['key'] == _defaultSelection,
        //             onSelected: () {
        //               setter(() => _defaultSelection = e['key']);
        //             },
        //           ),
        //         )
        //         .toList(),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            "Recommandations",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 10.0),
          child: Row(
            children: products
                .map((e) => FilterProductCard(
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
                    }))
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
          child: Text(
            "Catégories",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            children: categories
                .map(
                  (e) => CategoryCard(
                    data: e,
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
