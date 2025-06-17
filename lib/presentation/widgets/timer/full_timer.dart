import 'package:der_die_das/presentation/widgets/timer/circle_timer.dart';
import 'package:der_die_das/presentation/widgets/timer/timer_card.dart';
import 'package:flutter/material.dart';

class FullTimer extends StatelessWidget {
  const FullTimer({
    required this.timeLeft,
    required this.startingTime,
    super.key,
  });

  final int timeLeft;
  final int startingTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleTimer(pctOfTimeLeft: timeLeft / startingTime),
        TimerCard(timeLeft: timeLeft.toString()),
      ],
    );
  }
}
