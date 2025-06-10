import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  MyPainter({super.repaint, required this.pctOfTimeLeft});
  final double pctOfTimeLeft;

  @override
  void paint(Canvas canvas, Size size) {
    Paint drawCircle =
        Paint()
          ..strokeWidth = 8
          ..style = PaintingStyle.stroke
          ..color = Colors.orange
          ..strokeCap = StrokeCap.round;

    final rectangle = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    const pieValue = pi;

    canvas.drawArc(
      rectangle,
      pieValue * 3 / 2,
      -2 * pieValue * pctOfTimeLeft,
      false,
      drawCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
