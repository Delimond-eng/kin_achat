import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/slide_data.dart';
import 'arrow_shape.dart';
import 'utilities_widget.dart';

class SliderCard extends StatelessWidget {
  final SlideData data;
  const SliderCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Container(
            height: 180.0,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10.0,
                  offset: const Offset(0, 3),
                )
              ],
            ),
          ),
          ClipPath(
            clipper: ArrowDrawer(),
            child: Container(
              height: 180.0,
              width: size.width * .50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                  image: AssetImage(data.imgPath),
                ),
              ),
            ),
          ),
          Container(
            height: 180.0,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lobster(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Offre limitée, veuillez commandez dès maintenant ! ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.didactGothic(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const FilterBtn(
                          radius: 20.0,
                          title: "Voir détails",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
