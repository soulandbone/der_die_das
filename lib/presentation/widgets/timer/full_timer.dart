import 'package:der_die_das/presentation/widgets/timer/circle_timer.dart';
import 'package:der_die_das/presentation/widgets/timer/timer_card.dart';
import 'package:flutter/material.dart';

class FullTimer extends StatelessWidget {
  const FullTimer({required this.timeLeft, super.key});

  final int timeLeft;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleTimer(pctOfTimeLeft: timeLeft / 45),
        TimerCard(timeLeft: timeLeft.toString()),
      ],
    );
  }
}
