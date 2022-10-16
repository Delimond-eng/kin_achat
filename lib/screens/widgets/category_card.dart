import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category data;
  final bool hasGrid;
  const CategoryCard({
    Key key,
    this.data,
    this.hasGrid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: hasGrid
          ? const EdgeInsets.all(0.0)
          : const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () {},
          child: Column(
            children: [
              if (hasGrid) ...[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ],
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        image: AssetImage(data.iconPath),
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      )
                    ],
                    image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      image: AssetImage(data.iconPath),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ],
              const SizedBox(
                height: 5.0,
              ),
              Text(
                data.title,
                style: GoogleFonts.didactGothic(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
