import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollIndicator extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  const ScrollIndicator({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {},
          child: Center(
            child: Icon(
              icon,
              size: 15.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SlideDot extends StatelessWidget {
  final bool isActived;
  final Color activeColor;
  const SlideDot({
    Key key,
    this.isActived = false,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 4.0,
      width: isActived ? 20.0 : 15.0,
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isActived ? (activeColor ?? Colors.yellow[800]) : Colors.grey,
      ),
    );
  }
}

class FilterBtn extends StatelessWidget {
  final bool isSelected;
  final String title;
  final double radius;
  const FilterBtn({
    Key key,
    this.isSelected = false,
    this.title,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black45 : Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 4.0),
        border: isSelected ? const Border() : Border.all(color: Colors.black54),
      ),
      child: Text(
        title,
        style: GoogleFonts.didactGothic(
          color: isSelected ? Colors.white : Colors.black45,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
