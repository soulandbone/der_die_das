import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            if (state is! QuizFinished) {
              return CircularProgressIndicator();
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Summary(
                    totalQuestions: state.totalQuestions,
                    correctQuestions: state.correctQuestions.toDouble(),
                  ),
                  Gap(20),
                  IconButton(
                    onPressed: () {
                      context.read<QuestionBloc>().add(ResetQuiz());
                    },
                    icon: Icon(Icons.refresh),
                    iconSize: 44,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
