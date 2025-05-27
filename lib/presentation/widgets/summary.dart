import 'package:der_die_das/presentation/widgets/row_summary.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({
    required this.totalQuestions,
    required this.correctQuestions,
    super.key,
  });

  final double totalQuestions;
  final double correctQuestions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 80),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RowSummary(
              text: 'Total # of Questions',
              number: totalQuestions.toStringAsFixed(0),
            ),
            RowSummary(
              text: 'Total # of  Correct Questions',
              number: totalQuestions.toStringAsFixed(0),
            ),
            RowSummary(
              text: '% of completion',
              number: ((correctQuestions / totalQuestions) * 100)
                  .toStringAsFixed(2),
            ),
          ],
        ),
      ),
    );
  }
}
