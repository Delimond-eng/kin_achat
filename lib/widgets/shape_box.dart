import 'package:flutter/material.dart';

import 'shape_hexa.dart';

class ShapeBox extends StatelessWidget {
  final double height;
  final Color color;
  final Widget child;
  final Function onTap;
  const ShapeBox({Key key, this.height, this.color, this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                height: height ?? 200.0,
                width: size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(.1),
                      offset: Offset.zero,
                    )
                  ],
                ),
              ),
              ClipPath(
                clipper: ShapeHexa(),
                child: Container(
                  height: height ?? 200,
                  width: size.width - 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        Colors.white,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                height: height ?? 200,
                width: size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: child,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
