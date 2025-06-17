import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/row_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final questionsState = context.watch<QuestionBloc>().state as QuizFinished;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 80),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            questionsState.quizType == TypeOfQuiz.timed
                ? SizedBox()
                : RowSummary(
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
