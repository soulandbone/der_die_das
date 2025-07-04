import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/end.dart';
import 'package:der_die_das/presentation/widgets/cardQuestion/card_question.dart';
import 'package:der_die_das/presentation/widgets/current_score.dart';
import 'package:der_die_das/presentation/widgets/timer/full_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Der, Die, Das',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryFixed),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        //buildWhen: (previous, current) => current is QuestionState,
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuizInProgress) {
            var isTimed = state.quizType == TypeOfQuiz.timed;
            print('StartingTime time is ${state.startingTime}');

            return Column(
              children: [
                CurrentScore(state.currentScore!),
                Gap(80),
                isTimed
                    ? FullTimer(
                      timeLeft: state.remainingTime!,
                      startingTime: state.startingTime!,
                    )
                    : SizedBox(),
                Gap(50),
                CardQuestion(
                  question: state.questions![state.currentIndex!].word,
                ),
              ],
            );
          } else if (state is QuizFinished) {
            return EndScreen();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
