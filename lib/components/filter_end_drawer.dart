import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/utils/colors.dart';

class FilterEndDrawer extends StatelessWidget {
  const FilterEndDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      alignment: Alignment.topRight,
      margin: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.0),
              ),
            ),
            child: Center(
              child: Text(
                "Filtrer le produit par",
                style: GoogleFonts.didactGothic(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
