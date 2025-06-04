import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentScore extends StatelessWidget {
  const CurrentScore(this.score, {super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),

          child: Column(
            children: [
              Text(
                'Score',
                style: GoogleFonts.aleo(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(score.toString(), style: TextStyle(fontSize: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
