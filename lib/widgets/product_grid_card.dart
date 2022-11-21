import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import '../models/home_content.dart';

class GridProductCard extends StatelessWidget {
  final Produit data;
  final Function onPressed;
  final bool isList;
  const GridProductCard({
    Key key,
    this.data,
    this.onPressed,
    this.isList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isList) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 90.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: OptimizedCacheImage(
                          height: 90.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          imageUrl: data.image,
                          placeholder: (context, url) => const SizedBox(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.filter_hdr_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.titre,
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "Livraison 2 jours",
                          style: GoogleFonts.poppins(
                            color: Colors.yellow[900],
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${data.prix} ",
                                      style: GoogleFonts.anton(
                                        color: Colors.orange[800],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.devise,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  onTap: () {},
                                  child: const Center(
                                    child: Icon(
                                      CupertinoIcons.heart,
                                      size: 15.0,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(5),
                    ),
                    color: Colors.grey[400],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5),
                      ),
                      child: OptimizedCacheImage(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        imageUrl: data.image,
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.filter_hdr_rounded),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.titre,
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Livraison 2 jours",
                      style: GoogleFonts.poppins(
                        color: Colors.yellow[900],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${data.prix} ",
                                  style: GoogleFonts.anton(
                                    color: Colors.orange[800],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                TextSpan(
                                  text: data.devise,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () {},
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.heart,
                                  size: 15.0,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridProductCardPlaceholder extends StatelessWidget {
  const GridProductCardPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(5),
                ),
                color: Colors.grey[400],
              ),
              child: const Center(
                child: Icon(Icons.filter_hdr_rounded),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 12.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Container(
                  height: 3.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
