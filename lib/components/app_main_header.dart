import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/widgets/search_bar.dart';

class AppMainHeader extends StatelessWidget {
  final Function onFiltered;
  final Function onOpenCart;
  final Function onLoggedIn;
  const AppMainHeader(
      {Key key, this.onFiltered, this.onOpenCart, this.onLoggedIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Colors.indigo[300],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _logo(),
                  Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.indigo[100],
                          image: const DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/slider-1.jpeg"),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              offset: const Offset(0, 2),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: onLoggedIn,
                            child: const Center(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              offset: const Offset(0, 2),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: onOpenCart,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.shopping_cart,
                                size: 20.0,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              SearchBar(
                onFiltered: onFiltered,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*App Logo*//
  Widget _logo() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.staatliches(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
        ),
        children: [
          const TextSpan(
            text: "Kin",
          ),
          TextSpan(
            text: " Achat",
            style: GoogleFonts.staatliches(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
