import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinachat/widgets/rounded_curved_sharp.dart';

class CostumSlider extends StatelessWidget {
  const CostumSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    initAnimateSlide(pageController);
    return StatefulBuilder(
      builder: ((context, setter) {
        return SizedBox(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: 4,
            itemBuilder: (context, index) {
              return const SlideItem();
            },
            onPageChanged: (index) {
              setter(() {
                //currentSlide = index;
              });
            },
          ),
        );
      }),
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
  const SlideItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/slider-2.jpeg'),
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
                          'Bienvenue sur kinachat',
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
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[100],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const RoundedCurvedSharp(height: 100.0, width: 100.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
