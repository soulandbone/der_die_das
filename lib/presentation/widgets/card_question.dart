import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Answers { answer1, answer2, answer3 }

class CardQuestion extends StatefulWidget {
  const CardQuestion({required this.question, super.key});
  final String question;

  @override
  State<CardQuestion> createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestion> {
  String answer = 'Der';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '$answer ${widget.question}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Der'),
              Radio(
                value: 'Der',
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Die'),
              Radio(
                value: 'Die',
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Das'),
              Radio(
                value: 'Das',
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value!;
                  });
                },
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () {
              context.read<QuestionBloc>().add(AnswerConfirmed(answer: answer));
            },
            child: Text('Validate'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
