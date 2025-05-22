import 'package:flutter/material.dart';

class CurrentScore extends StatelessWidget {
  const CurrentScore(this.score, {super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Column(
          children: [
            Text(
              'Current Score',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(score.toString(), style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
