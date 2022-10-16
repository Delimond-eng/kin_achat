import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/pages/more_categories_viewer.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../screens/widgets/category_card.dart';
import '../screens/widgets/filter_card.dart';
import '../screens/widgets/filter_product_card.dart';
import '../screens/widgets/product_grid_card.dart';
import '../screens/widgets/search_bar.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _mainHeader(context),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Liste des produits",
                style: GoogleFonts.didactGothic(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.dashboard,
                          size: 18.0, color: Colors.indigo),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .6,
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: ((context, index) {
            var data = products[index];
            return GridProductCard(data: data);
          }),
        )
      ],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catégories",
                style: GoogleFonts.didactGothic(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoreCategoriesViewer(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        "Voir plus",
                        style: GoogleFonts.didactGothic(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
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

  //*Partie d'entete principal de l'appli pour la page principale*//
  Widget _mainHeader(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 152.0,
      width: size.width,
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _logo(),
                  Row(
                    children: [
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
                              color: Colors.grey.withOpacity(.3),
                              offset: const Offset(0, 2),
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.indigo[100],
                          borderRadius: BorderRadius.circular(5.0),
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
                            size: 20.0,
                            color: Colors.indigo,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const SearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.staatliches(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
        ),
        children: [
          const TextSpan(
            text: "Kin",
          ),
          TextSpan(
            text: " Achat",
            style: GoogleFonts.staatliches(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
