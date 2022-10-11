import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/product.dart';
import '../screens/widgets/utilities_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final PaletteGenerator paletteGenerator;
  final Product data;
  const ProductDetailsPage({Key key, this.paletteGenerator, this.data})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final PageController pageController = PageController(initialPage: 0);
  int currentSelectedItem = 0;

  void onchanged(index) {
    currentSelectedItem = index;

    pageController.animateToPage(
      currentSelectedItem,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/svgs/back.svg",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/svgs/shopping.svg",
                              color:
                                  widget.paletteGenerator.dominantColor.color,
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: StatefulBuilder(
                    builder: ((context, setter) {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    controller: pageController,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Hero(
                                          tag: widget.data.imgPath,
                                          child: widget.data.title
                                                  .contains("maroon")
                                              ? Image.asset(
                                                  (index == 0)
                                                      ? widget.data.imgPath
                                                      : (index == 1)
                                                          ? "assets/images/img-2.png"
                                                          : "assets/images/img-6.png",
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.scaleDown,
                                                )
                                              : Image.asset(
                                                  widget.data.imgPath,
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                        ),
                                      );
                                    },
                                    onPageChanged: (index) {
                                      setter(() {
                                        currentSelectedItem = index;
                                      });
                                    },
                                  ),
                                ),
                                _dotIndicatorSection(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (widget.data.title.contains("maroon")) ...[
                                  ...List.generate(
                                    3,
                                    (index) => Container(
                                      margin: const EdgeInsets.all(5.0),
                                      height: 80.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: widget.paletteGenerator
                                            .dominantColor.bodyTextColor,
                                        border: index == currentSelectedItem
                                            ? Border.all(
                                                color: widget.paletteGenerator
                                                    .dominantColor.color,
                                                width: 1.5,
                                              )
                                            : null,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          onTap: () {
                                            onchanged(index);
                                            setter(() {});
                                          },
                                          child: Center(
                                            child: Image.asset(
                                              (index == 0)
                                                  ? widget.data.imgPath
                                                  : (index == 1)
                                                      ? "assets/images/img-2.png"
                                                      : "assets/images/img-6.png",
                                              alignment: Alignment.center,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  ...List.generate(
                                    3,
                                    (index) => Container(
                                      margin: const EdgeInsets.all(5.0),
                                      height: 80.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: widget.paletteGenerator
                                            .dominantColor.bodyTextColor,
                                        border: index == currentSelectedItem
                                            ? Border.all(
                                                color: widget.paletteGenerator
                                                    .dominantColor.color,
                                                width: 1.5)
                                            : null,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          onTap: () {
                                            onchanged(index);
                                            setter(() {});
                                          },
                                          child: Center(
                                            child: Image.asset(
                                              widget.data.imgPath,
                                              alignment: Alignment.center,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.data.title,
                                style: GoogleFonts.oswald(
                                  color: widget
                                      .paletteGenerator.dominantColor.color,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  ${widget.data.price} ",
                                    style: GoogleFonts.anton(
                                      color:
                                          const Color.fromARGB(255, 31, 2, 2),
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "CDF",
                                    style: GoogleFonts.didactGothic(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(5),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5.0),
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: widget
                                      .paletteGenerator.dominantColor.color,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {},
                                    child: const Center(),
                                  ),
                                ),
                              ),
                              for (int i = 0; i < 5; i++) ...[
                                Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.primaries[i].shade900,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      child: const Center(),
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Description",
                          style: GoogleFonts.didactGothic(
                            color: widget.paletteGenerator.dominantColor.color,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit  consectetur adipisicing elit.",
                          style: GoogleFonts.didactGothic(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Autres Détails",
                          style: GoogleFonts.didactGothic(
                            color: widget.paletteGenerator.dominantColor.color,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ...List.generate(
                            6,
                            (index) => _detailItem(
                                title: "detail $index  ",
                                value: "velit mollitia numquam nemo !")),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: CustomBtn(
              color: widget.paletteGenerator.dominantColor.color,
              icon: Icons.add_shopping_cart_rounded,
              label: "Ajouter au panier",
              iconSize: 16.0,
              textColor: widget.paletteGenerator.dominantColor.bodyTextColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _detailItem({String title, String value}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: widget.paletteGenerator.dominantColor.color,
          ),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title ",
              style: GoogleFonts.didactGothic(
                color: widget.paletteGenerator.dominantColor.color,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.didactGothic(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dotIndicatorSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) ...[
          if (i == currentSelectedItem)
            SlideDot(
              activeColor: widget.paletteGenerator.dominantColor.color,
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
}

class CustomBtn extends StatelessWidget {
  final Color color, textColor;
  final IconData icon;
  final double iconSize;
  final String label;
  const CustomBtn({
    Key key,
    this.color,
    this.icon,
    this.label,
    this.iconSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor ?? Colors.black,
              size: iconSize ?? 15.0,
            ),
            if (label != null) ...[
              const SizedBox(
                width: 5.0,
              ),
              Text(
                label,
                style: GoogleFonts.didactGothic(
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
