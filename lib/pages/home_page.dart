import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/app_main_header.dart';
import 'package:kinachat/components/products_list_viewer.dart';

import '../components/filter_end_drawer.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../screens/widgets/category_card.dart';
import '../screens/widgets/filter_card.dart';
import '../screens/widgets/filter_product_card.dart';

import 'cart.dart';
import 'product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //*Cette list permet de simuler le filtrage de produits *//
  final List<Map> _filters = [
    {"key": "popular", "label": "Populaires"},
    {"key": "new", "label": "Recents"},
    {"key": "discount", "label": "Remises"},
  ];
  //*End List *//

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
      drawerScrimColor: Colors.transparent,
      endDrawer: const FilterEndDrawer(),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppMainHeader(
            onOpenCart: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
            },
            onLoggedIn: () {},
            onFiltered: () {
              _key.currentState.openEndDrawer();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
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
    var _defaultSelection = "popular";
    return StatefulBuilder(builder: (context, setter) {
      return Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              children: _filters
                  .map(
                    (e) => FilterBtn(
                      label: e['label'],
                      isSelected: e['key'] == _defaultSelection,
                      onSelected: () {
                        setter(() => _defaultSelection = e['key']);
                      },
                    ),
                  )
                  .toList(),
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
    });
  }
  //*End Filtering*//

  //*Affiche toutes les catégories de produits*//
  Widget _categoriesPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Text(
            "Catégories",
            style: GoogleFonts.didactGothic(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
