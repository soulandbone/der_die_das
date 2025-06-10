import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    // Bottom left
    path.lineTo(0, size.height);

    path.lineTo(size.width * 0.2, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.7,
      size.width * 0.8,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Back to start
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
