import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/widgets/rounded_curved_sharp.dart';
import 'package:lottie/lottie.dart';

import '../widgets/utilities_widget.dart';

class CostumSlider extends StatelessWidget {
  const CostumSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return Builder(builder: (context) {
      int currentSlide = 0;
      initAnimateSlide(pageController);
      return StatefulBuilder(
        builder: ((context, setter) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: sliders.length,
                  itemBuilder: (context, index) {
                    return sliders[index];
                  },
                  onPageChanged: (index) {
                    setter(() {
                      currentSlide = index;
                    });
                  },
                ),
              ),
              ZoomIn(
                child: _sliderIndicators(
                  currentSlide,
                  length: sliders.length,
                ),
              )
            ],
          );
        }),
      );
    });
  }

  Widget _sliderIndicators(int currentSlide, {int length}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < length; i++) ...[
          if (i == currentSlide)
            const SlideDot(
              activeColor: Colors.indigo,
              isActived: true,
            )
          else
            const SlideDot(
              isActived: false,
            )
        ]
      ],
    );
  }

  initAnimateSlide(PageController pageController) {
    Future.delayed(const Duration(seconds: 7)).then((_) {
      int nextPage = pageController.page.round() + 1;
      if (nextPage == 4) {
        nextPage = 0;
      }
      pageController
          .animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          )
          .then((_) => initAnimateSlide(pageController));
    });
  }
}

class SlideItem extends StatelessWidget {
  final String imgBgPath, title, desc, shapeImgPath;
  const SlideItem({
    Key key,
    this.imgBgPath,
    @required this.title,
    this.desc,
    @required this.shapeImgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBgPath ?? 'assets/images/slider-2.jpeg'),
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.black.withOpacity(.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomIn(
                        child: Text(
                          title,
                          style: GoogleFonts.staatliches(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      FadeInUpBig(
                        child: Text(
                          desc,
                          style: GoogleFonts.didactGothic(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[100],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ZoomIn(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const RoundedCurvedSharp(
                        height: 100.0,
                        width: 100.0,
                      ),
                      if (shapeImgPath.contains(".json")) ...[
                        Positioned(
                          top: -5,
                          child: Lottie.asset(
                            shapeImgPath,
                            fit: BoxFit.scaleDown,
                            height: 120.0,
                            width: 120.0,
                          ),
                        )
                      ] else ...[
                        Image.asset(
                          shapeImgPath,
                          fit: BoxFit.scaleDown,
                          height: 120.0,
                          width: 120.0,
                        ),
                      ]
                    ],
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

//* List des widgets sliders *//
List<Widget> sliders = [
  const SlideItem(
    title: "Bienvenue cher client !",
    desc:
        "Faites vos achats en toute facilité et profitez des plusieurs services mis en votre disposition sur notre plateforme !",
    shapeImgPath: "assets/lotties/a-vector_4.json",
  ),
  const SlideItem(
    title: "Livraison rapide !",
    desc:
        "En achetant chez nous, vous bénéficiez d'un service de livraison ultra rapide, où que vous soyez !",
    shapeImgPath: "assets/vectors/vector_3.png",
  ),
  const SlideItem(
    title: "Achetez facilement ! ",
    desc:
        "Notre application vous facilite les tâches ardues, elle est facile à utiliser, bénéficiez d'une gamme large des produits et services !",
    shapeImgPath: "assets/vectors/vector_2.png",
  ),
  const SlideItem(
    title: "Commencez maintenant ! ",
    desc:
        "Bénéficiez d'une réduction de 10% pour votre première commande sur notre application !",
    shapeImgPath: "assets/lotties/a-vector_4.json",
  ),
];
