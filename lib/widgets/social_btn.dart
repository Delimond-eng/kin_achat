import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialBtn extends StatelessWidget {
  final String label;
  final String icon;
  final Function onPressed;
  const SocialBtn({Key key, this.label, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: const Offset(0, 2),
            blurRadius: 2,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svgs/$icon.svg",
                  height: 30.0,
                  width: 30.0,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
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
