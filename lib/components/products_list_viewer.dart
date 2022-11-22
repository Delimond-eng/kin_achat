import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/api/repositories/public_repo.dart';
import 'package:kinachat/db/repository.dart';
import 'package:kinachat/utils/dialogs/modals.dart';

import '../models/home_content.dart';
import '../pages/product_details.dart';
import '../widgets/product_grid_card.dart';

class ProductsListViewer extends StatelessWidget {
  final List<Produit> dataList;
  final String descriptionLabel;
  final bool isScrollable;
  final bool isDataDetail;
  final bool isListFirst;
  const ProductsListViewer(
      {Key key,
      @required this.dataList,
      this.descriptionLabel,
      this.isScrollable = false,
      this.isDataDetail = false,
      this.isListFirst = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isList = isListFirst;
    return StatefulBuilder(builder: (context, setter) {
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
                FadeInRight(
                  child: Text(
                    descriptionLabel ?? "Nos produits",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                FadeInLeft(
                  child: Container(
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
                          setter(() => isList = !isList);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            isList ? Icons.dashboard : CupertinoIcons.list_dash,
                            size: 18.0,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (!isList) ...[
            if (isScrollable) ...[
              Expanded(
                child: FadeInUp(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics: isScrollable
                        ? const ScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .6,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: dataList.length,
                    itemBuilder: ((context, index) {
                      var data = dataList[index];
                      return ZoomIn(
                        child: GridProductCard(
                          data: data,
                          onPressed: () {
                            Xloading.showLottieLoading(context);
                            PublicRepo.getSelectedProductData(data.produitId)
                                .then((d) {
                              Xloading.dismiss();
                              if (d != null) {
                                if (!isDataDetail) {
                                  InternalRepo.getIsFavorite(data)
                                      .then((isFavorite) {
                                    Get.to(
                                      ProductSelectedDetails(
                                          data: data, isFavorite: isFavorite),
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      transition: Transition.circularReveal,
                                    );
                                  });
                                }
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
              )
            ] else ...[
              FadeInUp(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  physics: isScrollable
                      ? const ScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: dataList.length,
                  itemBuilder: ((context, index) {
                    var data = dataList[index];
                    return ZoomIn(
                      child: GridProductCard(
                        data: data,
                        onPressed: () {
                          Xloading.showLottieLoading(context);
                          PublicRepo.getSelectedProductData(data.produitId)
                              .then((d) {
                            Xloading.dismiss();
                            if (d != null) {
                              if (!isDataDetail) {
                                InternalRepo.getIsFavorite(data)
                                    .then((isFavorite) {
                                  Get.to(
                                    ProductSelectedDetails(
                                        data: data, isFavorite: isFavorite),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    transition: Transition.circularReveal,
                                  );
                                });
                              }
                            }
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ]
          ],
          if (isList) ...[
            if (isScrollable) ...[
              Expanded(
                child: FadeInUp(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: dataList.length,
                    physics: isScrollable
                        ? const ScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      var data = dataList[index];
                      return ZoomIn(
                        child: GridProductCard(
                          data: data,
                          isList: true,
                          onPressed: () {
                            Xloading.showLottieLoading(context);
                            PublicRepo.getSelectedProductData(data.produitId)
                                .then((d) {
                              Xloading.dismiss();
                              if (d != null) {
                                if (!isDataDetail) {
                                  InternalRepo.getIsFavorite(data)
                                      .then((isFavorite) {
                                    Get.to(
                                      ProductSelectedDetails(
                                          data: data, isFavorite: isFavorite),
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      transition: Transition.circularReveal,
                                    );
                                  });
                                }
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
              )
            ] else ...[
              FadeInUp(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: dataList.length,
                  physics: isScrollable
                      ? const ScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    var data = dataList[index];
                    return ZoomIn(
                      child: GridProductCard(
                        data: data,
                        isList: true,
                        onPressed: () {
                          Xloading.showLottieLoading(context);
                          PublicRepo.getSelectedProductData(data.produitId)
                              .then((d) {
                            Xloading.dismiss();
                            if (d != null) {
                              if (!isDataDetail) {
                                InternalRepo.getIsFavorite(data)
                                    .then((isFavorite) {
                                  Get.to(
                                    ProductSelectedDetails(
                                        data: data, isFavorite: isFavorite),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    transition: Transition.circularReveal,
                                  );
                                });
                              }
                            }
                          });
                        },
                      ),
                    );
                  }),
                ),
              )
            ]
          ]
        ],
      );
    });
  }
}
