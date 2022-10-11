import 'package:flutter/material.dart';

class ShapeCat extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double cornerSize = 10.0;
    double diagonalHeight = 10.0;

    path.moveTo(0, cornerSize);
    path.lineTo(0, size.height - cornerSize);
    path.quadraticBezierTo(0, size.height, cornerSize, size.height);
    path.lineTo(size.width - cornerSize, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - cornerSize);
    path.lineTo(size.width, diagonalHeight + cornerSize);
    path.quadraticBezierTo(size.width, diagonalHeight, size.width - cornerSize,
        diagonalHeight * .9);
    path.lineTo(cornerSize * 2, cornerSize);
    path.quadraticBezierTo(0, 0, 0, cornerSize);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
