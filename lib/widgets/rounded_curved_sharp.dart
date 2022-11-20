import 'dart:math';

import 'package:flutter/material.dart';

class RoundedCurvedSharp extends StatelessWidget {
  final double height, width;
  const RoundedCurvedSharp({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.shade700, color.shade200]),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(90.0),
          bottomRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(20.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 10.0,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
    );
  }
}
