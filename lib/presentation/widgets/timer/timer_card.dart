import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({required this.timeLeft, super.key});

  final String timeLeft;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            timeLeft,
            style: GoogleFonts.prata(
              textStyle: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
