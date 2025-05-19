import 'package:flutter/material.dart';

enum Answers { answer1, answer2, answer3 }

class CardQuestion extends StatefulWidget {
  const CardQuestion({
    required this.question,
    required this.correctAnswer,
    super.key,
  });
  final String question;
  final String correctAnswer;

  @override
  State<CardQuestion> createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestion> {
  Answers answer = Answers.answer1;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '___ Spiegel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Der'),
              Radio(
                value: Answers.answer1,
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
                value: Answers.answer2,
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
                value: Answers.answer3,
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(onPressed: () {}, child: Text('Validate')),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
