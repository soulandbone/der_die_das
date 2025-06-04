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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RowSummary(
              firstTextColor: Theme.of(context).colorScheme.primary,
              text: 'Questions',
              number: totalQuestions.toStringAsFixed(0),
            ),
            RowSummary(
              firstTextColor: Theme.of(context).colorScheme.secondary,
              text: 'Correct Questions',
              number: correctQuestions.toStringAsFixed(0),
            ),
            RowSummary(
              firstTextColor: Theme.of(context).colorScheme.tertiary,
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
