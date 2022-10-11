import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/category.dart';

class Cardcategory extends StatelessWidget {
  final Category data;
  const Cardcategory({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      height: 80.0,
      width: 80.0,
      decoration: BoxDecoration(
        color: color.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.shade400,
          width: .5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  data.iconPath,
                  color: color.shade900,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.didactGothic(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
