import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinachat/utils/colors.dart';
import 'package:kinachat/utils/dialogs/modals.dart';
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

  //* List des widgets sliders *//
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
  //*end initialisation list sliders*//

  //*Main build*//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              secondaryColor,
              primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
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
                          Xloading.showLottieLoading(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false).then((_) => Xloading.dismiss());
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/svgs/next_big.svg",
                            height: 20.0,
                            width: 20,
                            color: secondaryColor,
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
            FadeInDown(
              child: Lottie.asset(
                vectorPath,
                animate: true,
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
              ),
            )
          ] else ...[
            FadeInDown(
              child: Image.asset(
                vectorPath,
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
          const SizedBox(
            height: 15.0,
          ),
          ZoomIn(
            child: Text(
              "$title ",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Staatliches',
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          FadeInUpBig(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DidactGothic',
                fontWeight: FontWeight.w600,
                color: Colors.grey[100],
              ),
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
      height: 5.0,
      width: isSelected ? 18.0 : 10.0,
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: isSelected ? secondaryColor : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
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
