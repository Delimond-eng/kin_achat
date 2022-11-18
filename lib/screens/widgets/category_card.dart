import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svgs/clothes.svg",
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
                  data.title,
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
