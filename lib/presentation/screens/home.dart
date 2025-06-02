import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/end.dart';
import 'package:der_die_das/presentation/widgets/card_question.dart';
import 'package:der_die_das/presentation/widgets/current_score.dart';
import 'package:der_die_das/presentation/widgets/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
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
          } else if (state is QuizProgress && !state.isFinished) {
            return Column(
              children: [
                Gap(40),
                CurrentScore(state.currentScore),
                Gap(120),
                CardQuestion(
                  question: state.questions[state.currentIndex].word,
                ),
              ],
            );
          } else {
            return EndScreen();
          }
        },
      ),
    );
  }
}
