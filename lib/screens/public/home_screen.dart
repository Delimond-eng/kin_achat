import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../models/category.dart';
import '../../models/product.dart';
import '../../models/slide_data.dart';
import '../../pages/product_details_page.dart';
import '../widgets/animated_header.dart';
import '../widgets/card_pub.dart';
import '../widgets/category_card.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/slider_card.dart';
import '../widgets/utilities_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentSlide = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initAnimateSlide());
  }

  initAnimateSlide() {
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
          .then((_) => initAnimateSlide());
    });
  }

  Future<PaletteGenerator> imageGenerateColor({String imgPath}) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(imgPath),
      maximumColorCount: 20,
    );
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          AnimatedHeader(
            height: 120.0,
            child: Container(
              width: size.width,
              height: 40.0,
              margin: const EdgeInsets.fromLTRB(5, 50.0, 5, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35.0,
                          width: 35.0,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(40.0),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  "assets/svgs/menu.svg",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        logo()
                      ],
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.person,
                          color: Colors.indigo,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBar(),
                  const SizedBox(height: 15.0),
                  StatefulBuilder(
                    builder: (context, setter) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 190.0,
                            width: size.width,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: pageController,
                              itemCount: sliders.length,
                              itemBuilder: (context, index) {
                                return SliderCard(
                                  data: sliders[index],
                                );
                              },
                              onPageChanged: (index) {
                                setter(() {
                                  currentSlide = index;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < sliders.length; i++) ...[
                                if (i == currentSlide)
                                  const SlideDot(
                                    isActived: true,
                                  )
                                else
                                  const SlideDot(
                                    isActived: false,
                                  )
                              ]
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Catégories",
                          style: GoogleFonts.didactGothic(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ...List.generate(
                          categories.length,
                          (index) => Cardcategory(
                            data: categories[index],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: Text(
                      "Recommandations",
                      style: GoogleFonts.didactGothic(
                        color: Colors.black54,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          products.length,
                          ((index) => CardPub(
                                data: products[index],
                                height: 170.0,
                                onPressed: () async {
                                  var paletteImageColor =
                                      await imageGenerateColor(
                                    imgPath: products[index].imgPath,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        data: products[index],
                                        paletteGenerator: paletteImageColor,
                                      ),
                                    ),
                                  );
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products",
                          style: GoogleFonts.didactGothic(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const ScrollIndicator(
                          icon: Icons.list,
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .7,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return GridProductCard(
                        data: product,
                        onPressed: () async {
                          var paletteImageColor = await imageGenerateColor(
                            imgPath: product.imgPath,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                data: product,
                                paletteGenerator: paletteImageColor,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget logo() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.ultra(
          color: Colors.white,
          fontSize: 18.0,
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
            style: GoogleFonts.ultra(
              color: Colors.yellow,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  color: Colors.red[900].withOpacity(.2),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
