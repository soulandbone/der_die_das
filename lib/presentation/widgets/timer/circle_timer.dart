import 'package:der_die_das/presentation/widgets/timer/painters/my_painter.dart';
import 'package:flutter/material.dart';

class CircleTimer extends StatelessWidget {
  const CircleTimer({required this.pctOfTimeLeft, super.key});

  final double pctOfTimeLeft;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 400),
      painter: MyPainter(pctOfTimeLeft: pctOfTimeLeft),
    );
  }
}
