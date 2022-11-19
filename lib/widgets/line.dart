import 'package:flutter/material.dart';

class GLine extends StatelessWidget {
  final Color color;
  final double width, thinkness;

  const GLine({Key key, this.color, this.width, this.thinkness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thinkness ?? 2,
      width: width ?? 12.0,
      color: color ?? Colors.black,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
    );
  }
}
