import 'package:der_die_das/presentation/widgets/row_summary.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({
    required this.totalQuestions,
    required this.correctQuestions,
    super.key,
  });

  final int totalQuestions;
  final int correctQuestions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RowSummary(text: 'Total # of Questions', number: totalQuestions),
          RowSummary(
            text: 'Total # of  Correct Questions',
            number: correctQuestions,
          ),
        ],
      ),
    );
  }
}
