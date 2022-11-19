import 'package:flutter/widgets.dart';

class ArrowDrawer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * .85, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * .85, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
