import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/drawer/main_drawer.dart';

import 'package:der_die_das/presentation/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizBloc = context.read<QuestionBloc>();

    final questionsState = context.watch<QuestionBloc>().state as QuizFinished;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Summary(
              totalQuestions: questionsState.totalQuestions.toDouble(),
              correctQuestions: questionsState.correctQuestions.toDouble(),
            ),
            Gap(20),
            IconButton(
              onPressed: () {
                quizBloc.add(ResetQuiz());
              },
              icon: Icon(Icons.refresh),
              iconSize: 44,
            ),
          ],
        ),
      ),
    );
  }
}
