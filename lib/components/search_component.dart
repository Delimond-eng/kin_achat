import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/components/cart_viewer.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:kinachat/models/home_content.dart';
import 'package:kinachat/widgets/search_bar.dart';
import 'package:lottie/lottie.dart';

import '../api/repositories/public_repo.dart';
import '../db/repository.dart';
import '../pages/product_details.dart';
import '../utils/colors.dart';
import '../utils/dialogs/modals.dart';
import '../widgets/cart_openning_btn.dart';
import '../widgets/product_grid_card.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> sKey = GlobalKey();
    List<Produit> _foundedItems = <Produit>[];
    final searchController = TextEditingController();
    return Scaffold(
      key: sKey,
      endDrawer: const CartViewer(),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          _header(context, sKey),
          Expanded(
            child: StatefulBuilder(builder: (context, setter) {
              return Column(
                children: [
                  SearchBar(
                    controller: searchController,
                    onChanged: (kWord) {
                      if (kWord.isNotEmpty) {
                        var s = homeController.produits
                            .where((el) => el.titre
                                .toLowerCase()
                                .contains(kWord.toLowerCase()))
                            .toList();
                        setter(() {
                          if (s.isNotEmpty) {
                            _foundedItems.clear();
                            _foundedItems.addAll(s);
                          }
                        });
                      } else {
                        setter(() => _foundedItems.clear());
                      }
                    },
                  ),
                  Expanded(
                    child: _foundedItems.isEmpty
                        ? _emptyState()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(10.0),
                            itemCount: _foundedItems.length,
                            itemBuilder: (context, index) {
                              var data = _foundedItems[index];
                              return ZoomIn(
                                child: GridProductCard(
                                  data: data,
                                  isList: true,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    Xloading.showLottieLoading(context);
                                    PublicRepo.getSelectedProductData(
                                      data.produitId,
                                    ).then((d) {
                                      Xloading.dismiss();
                                      homeController.selectedProduit.value =
                                          data;
                                      if (d != null) {
                                        InternalRepo.getIsFavorite(data)
                                            .then((isFavorite) {
                                          Get.to(
                                            ProductSelectedDetails(
                                                isSearched: true,
                                                isFavorite: isFavorite),
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            transition:
                                                Transition.circularReveal,
                                          );
                                        });
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _emptyState() {
    return ZoomIn(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Lottie.asset("assets/lotties/search.json"),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, GlobalKey<ScaffoldState> sKey) {
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
                  Row(
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
                              Get.back();
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
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Recherche...",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  CartOpenningBtn(
                    scaffoldKey: sKey,
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
