import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/home.dart';
import 'package:der_die_das/presentation/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizBloc = context.read<QuestionBloc>();
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
                Gap(20),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    quizBloc.add(ResetQuiz());
                  },
                  icon: Icon(Icons.refresh),
                  iconSize: 44,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
