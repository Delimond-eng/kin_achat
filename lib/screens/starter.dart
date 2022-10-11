import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'public/home_screen.dart';

class Starter extends StatefulWidget {
  const Starter({Key key}) : super(key: key);

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  int currentImageIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  List<Widget> sliders = [
    const StarterSliderItem(
      isFirst: true,
      title: "Bienvenue cher client !",
      subtitle:
          "Faites vos achats en toute facilité et profitez des plusieurs services mis en votre disposition sur notre plateforme !",
      vectorPath: "assets/lotties/a-vector_4.json",
    ),
    const StarterSliderItem(
      title: "Livraison rapide !",
      subtitle:
          "En achetant chez nous, vous bénéficiez d'un service de livraison ultra rapide, où que vous soyez !",
      vectorPath: "assets/vectors/vector_3.png",
    ),
    const StarterSliderItem(
      title: "Achetez facilement ! ",
      isFirst: true,
      subtitle:
          "Notre application vous facilite les tâches ardues, elle est facile à utiliser, bénéficiez d'une gamme large des produits et services !",
      vectorPath: "assets/vectors/vector_2.png",
    ),
    const StarterSliderItem(
      title: "Commencez maintenant ! ",
      subtitle:
          "Bénéficiez d'une réduction de 10% pour votre première commande sur notre application !",
      vectorPath: "assets/lotties/a-vector_5.json",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          _coverBg(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.withOpacity(.6),
                  Colors.indigo.withOpacity(.6),
                  Colors.indigo.withOpacity(.8),
                  Colors.indigo.withOpacity(.9),
                  Colors.indigo[900]
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return sliders[index];
                    },
                    itemCount: sliders.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < sliders.length; i++) ...[
                            if (i == currentImageIndex)
                              const Dot(isSelected: true)
                            else
                              const Dot()
                          ]
                        ],
                      ),
                      Container(
                        height: 40.0,
                        width: 80.0,
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo[400],
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(.1),
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/svgs/next_big.svg",
                                height: 20.0,
                                width: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ////*
  ///***[@Widget] image de fond transparent */
  ////*
  Widget _coverBg() {
    var _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      width: _size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage("assets/images/cover_0.jpg"),
        ),
      ),
    );
  }

  ////*
  ///***[@Widget] le titre en haut de la page */
  ////*
  Widget _logo() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.ultra(
                  color: Colors.white,
                  fontSize: 33.0,
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
                    text: "Kin ",
                  ),
                  TextSpan(
                    text: "Achat",
                    style: GoogleFonts.ultra(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Acheter partout et en toute facilité !",
              style: GoogleFonts.didactGothic(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StarterSliderItem extends StatelessWidget {
  final String vectorPath;
  final String title, subtitle;
  final bool isFirst;

  const StarterSliderItem({
    Key key,
    this.vectorPath,
    this.title,
    this.subtitle,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (vectorPath.contains(".json")) ...[
            Lottie.asset(
              vectorPath,
              animate: true,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
            )
          ] else ...[
            Image.asset(
              vectorPath,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
            ),
          ],
          Text(
            "$title ",
            textAlign: TextAlign.center,
            style: GoogleFonts.ultra(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.didactGothic(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[100],
            ),
          )
        ],
      ),
    );
  }
}

///**OU DOT INDICATOR */
///
class Dot extends StatelessWidget {
  final bool isSelected;
  const Dot({
    Key key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isSelected ? 12 : 10.0,
      width: isSelected ? 12 : 10.0,
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
      ),
      duration: const Duration(milliseconds: 500),
    );
  }
}
