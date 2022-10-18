import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product.dart';
import '../screens/widgets/product_grid_card.dart';

class ProductsListViewer extends StatelessWidget {
  final List<Product> dataList;
  final String descriptionLabel;
  final bool isScrollable;
  const ProductsListViewer({
    Key key,
    @required this.dataList,
    this.descriptionLabel,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isList = false;
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
                Text(
                  descriptionLabel ?? "Liste des produits",
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
                )
              ],
            ),
          ),
          if (!isList) ...[
            GridView.builder(
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
                return GridProductCard(data: data);
              }),
            )
          ],
          if (isList) ...[
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              itemCount: dataList.length,
              physics: isScrollable
                  ? const ScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                var data = dataList[index];
                return GridProductCard(
                  data: data,
                  isList: true,
                );
              }),
            )
          ]
        ],
      );
    });
  }
}
