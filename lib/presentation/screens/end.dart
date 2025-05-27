import 'package:der_die_das/presentation/bloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionBloc, QuestionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final state = context.watch<QuestionBloc>().state as QuizProgress;
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Summary(
                  totalQuestions: state.questions.length.toDouble(),
                  correctQuestions: state.totalCorrect.toDouble(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
