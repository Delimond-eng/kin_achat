import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedHeader extends StatefulWidget {
  final double height;
  final Widget child;
  const AnimatedHeader({Key key, this.height, this.child}) : super(key: key);

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        value: 0.0,
        duration: const Duration(seconds: 5),
        upperBound: 1,
        lowerBound: -1,
        vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: controller,
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.indigo[400],
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          builder: (context, child) => ClipPath(
            child: child,
            clipper: DrawerAnimated(controller.value),
          ),
        ),
        if (widget.child != null) ...[widget.child]
      ],
    );
  }
}

class DrawerAnimated extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawerAnimated(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 30 * math.cos(move * slice);

    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
