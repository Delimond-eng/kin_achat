import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../models/product.dart';
import 'shape_box.dart';

class CardPub extends StatelessWidget {
  final Product data;
  final double height;
  final Function onPressed;
  const CardPub({
    Key key,
    this.height,
    this.data,
    this.onPressed,
  }) : super(key: key);

  Future<PaletteGenerator> imageGenerateColor() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(data.imgPath),
      maximumColorCount: 20,
    );
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaletteGenerator>(
      future: imageGenerateColor(),
      builder: ((context, snapshot) {
        if (snapshot.data != null) {
          return ShapeBox(
            onTap: onPressed,
            height: height,
            color: snapshot.data.dominantColor.color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.poppins(
                          color: snapshot.data.dominantColor.bodyTextColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "livraison 1h",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${data.price} ",
                              style: GoogleFonts.anton(
                                color: Colors.yellow,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                            TextSpan(
                              text: "CDF",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200].withOpacity(.7),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        data.imgPath,
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return ShapeBox(
            onTap: onPressed,
            height: height,
            color: Colors.yellow[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "livraison 1h au max.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${data.price} ",
                              style: GoogleFonts.anton(
                                color: Colors.yellow,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                            TextSpan(
                              text: "CDF",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100].withOpacity(.6),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        data.imgPath,
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
