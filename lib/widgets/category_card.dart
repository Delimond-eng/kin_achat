import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/api/repositories/public_repo.dart';
import 'package:kinachat/global/controllers.dart';
import 'package:kinachat/pages/categorie_products.dart';
import 'package:kinachat/utils/dialogs/modals.dart';

import '../models/home_content.dart';

class CategoryCard extends StatelessWidget {
  final Categorie data;
  final bool hasGrid;

  const CategoryCard({
    Key key,
    this.data,
    this.hasGrid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () async {
            Xloading.showLottieLoading(context);
            PublicRepo.getSelectedCategoriesProducts(data.produitCategorieId)
                .then((res) {
              Xloading.dismiss();
              if (res != null) {
                homeController.categorieProduits.addAll(res.content.produits);
                Get.to(
                  CategorieProducts(data: data),
                  transition: Transition.circularReveal,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                );
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  data.icon,
                  color: Colors.black,
                  fit: BoxFit.scaleDown,
                  height: 25.0,
                  width: 25.0,
                ),
                const Icon(
                  CupertinoIcons.chevron_forward,
                  size: 12.0,
                ),
                Text(
                  data.categorie,
                  style: GoogleFonts.poppins(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCardPlaceholder extends StatelessWidget {
  const CategoryCardPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              height: 8.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
