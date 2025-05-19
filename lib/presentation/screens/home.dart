import 'package:der_die_das/presentation/bloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/card_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Whatever')),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        //buildWhen: (previous, current) => current is QuestionState,
        builder: (context, state) {
          if (state is QuestionsLoading) {
            print('inside of QuestionsLoading');
            return Center(child: CircularProgressIndicator());
          } else if (state is QuestionsLoaded) {
            print('it is inside of QuestionLoaded');
            return ListView.builder(
              itemCount: state.questions.length,
              itemBuilder:
                  (context, index) => CardQuestion(
                    question: state.questions[index].word,
                    correctAnswer: state.questions[index].correctAnswer,
                  ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
