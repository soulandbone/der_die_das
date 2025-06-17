import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/quiz.dart';
import 'package:der_die_das/presentation/widgets/optionMenuItem/clipper/my_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizOption {
  QuizOption({required this.quizType, this.numberOfQuestions, this.totalTime});

  int? numberOfQuestions;
  final TypeOfQuiz quizType;
  final int? totalTime;
}

class OptionMenuItem extends StatelessWidget {
  const OptionMenuItem({
    required this.index,
    required this.text,
    required this.color,
    super.key,
  });

  final Color color;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    Map<int, QuizOption> quizOptions = {
      0: QuizOption(quizType: TypeOfQuiz.untimed, numberOfQuestions: 10),
      1: QuizOption(quizType: TypeOfQuiz.untimed, numberOfQuestions: 20),
      2: QuizOption(quizType: TypeOfQuiz.untimed, numberOfQuestions: 30),
      3: QuizOption(quizType: TypeOfQuiz.timed, totalTime: 30),
      4: QuizOption(quizType: TypeOfQuiz.timed, totalTime: 60),
      5: QuizOption(quizType: TypeOfQuiz.timed, totalTime: 120),
    };

    final selectedOption = quizOptions[index];

    final quizBloc = context.read<QuestionBloc>();
    return InkWell(
      splashColor: Colors.purple,
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return QuizScreen();
            },
          ),
        );
        quizBloc.add(
          StartQuizWithOptions(
            numberOfQuestions:
                selectedOption!.quizType == TypeOfQuiz.untimed
                    ? selectedOption.numberOfQuestions
                    : null,
            quizType: selectedOption.quizType,
            time:
                selectedOption.quizType == TypeOfQuiz.timed
                    ? selectedOption.totalTime
                    : null,
          ),
        );
      },
      child: ClipPath(
        clipper: MyClipper(),
        child: Card(
          elevation: 2,
          child: Container(
            color: color,
            child: Center(
              child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
