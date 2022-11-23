import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/api/repositories/public_repo.dart';
import 'package:kinachat/components/app_main_header.dart';
import 'package:kinachat/components/costum_slider.dart';
import 'package:kinachat/components/products_list_viewer.dart';
import 'package:kinachat/components/search_component.dart';
import 'package:kinachat/screens/auth/authenticate.dart';
import 'package:kinachat/utils/dialogs/modals.dart';
import 'package:kinachat/widgets/product_grid_card.dart';

import '../components/cart_viewer.dart';
import '../db/repository.dart';
import '../global/controllers.dart';
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
            sKey: _key,
            onLoggedIn: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[200],
                builder: (context) {
                  return const Authenticate();
                },
              );
            },
            onSearched: () {
              Get.to(
                const SearchComponent(),
                duration: const Duration(milliseconds: 1000),
                fullscreenDialog: true,
                transition: Transition.circularReveal,
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(() => Column(
                    children: [
                      _mainSlider(),
                      _categoriesPart(context),
                      _productsRecommanded(context),
                      _allProducts(context)
                    ],
                  )),
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
    if (homeController.isHomeLoading.value) {
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
            return ZoomIn(child: const GridProductCardPlaceholder());
          }),
        ),
      );
    }
    return ProductsListViewer(
      dataList: homeController.produits,
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
          child: homeController.isHomeLoading.value
              ? Row(
                  children: List.generate(
                      4,
                      (index) => FadeInLeft(
                          child: const FilterProductCardPlaceholder())),
                )
              : Row(
                  children: homeController.produits
                      .map(
                        (e) => FadeInLeftBig(
                          child: FilterProductCard(
                              data: e,
                              onPressed: () {
                                Xloading.showLottieLoading(context);
                                PublicRepo.getSelectedProductData(e.produitId)
                                    .then((d) {
                                  Xloading.dismiss();
                                  homeController.selectedProduit.value = e;
                                  if (d != null) {
                                    InternalRepo.getIsFavorite(e)
                                        .then((isFavorite) {
                                      Get.to(
                                        ProductSelectedDetails(
                                            isFavorite: isFavorite),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        transition: Transition.circularReveal,
                                      );
                                    });
                                  }
                                });
                              }),
                        ),
                      )
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
          child: homeController.isHomeLoading.value
              ? Row(
                  children: List.generate(
                    4,
                    (index) => ZoomIn(
                      child: const CategoryCardPlaceholder(),
                    ),
                  ).toList(),
                )
              : Row(
                  children: homeController.categories
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
