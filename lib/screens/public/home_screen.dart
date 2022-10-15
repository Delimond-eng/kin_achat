import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/models/category.dart';
import 'package:kinachat/screens/widgets/search_bar.dart';

import '../widgets/category_card.dart';
import '../widgets/filter_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          _categoriesPart(context),
          _productsFiltering(context)
        ],
      ),
    );
  }

  //*Affichage des produits par filtrage*//
  Widget _productsFiltering(BuildContext context) {
    var _defaultSelection = "popular";
    return StatefulBuilder(builder: (context, setter) {
      return Column(
        children: [
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

  /*App Logo*/
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
