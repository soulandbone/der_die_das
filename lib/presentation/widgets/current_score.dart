import 'package:flutter/material.dart';

class CurrentScore extends StatelessWidget {
  const CurrentScore(this.score, {super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.red),
      child: Column(
        children: [
          Text(
            'Current Score',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(score.toString()),
        ],
      ),
    );
  }
}
