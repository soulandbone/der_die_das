import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:der_die_das/presentation/widgets/cardQuestion/options_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

enum Answers { answer1, answer2, answer3 }

class CardQuestion extends StatefulWidget {
  const CardQuestion({required this.question, this.textSize = 18, super.key});
  final String question;
  final double textSize;

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
          Gap(20),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              if (state is LightTheme) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '__ ${widget.question}',
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                );
              } else if (state is ShowArticle) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '$answer ${widget.question}',
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionsText(text: 'Der', textSize: widget.textSize),
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
              OptionsText(text: 'Die', textSize: widget.textSize),
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
              OptionsText(text: 'Das', textSize: widget.textSize),
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
          Gap(18),

          ElevatedButton(
            onPressed: () {
              context.read<QuestionBloc>().add(AnswerConfirmed(answer: answer));
            },
            child: Text(
              'Answer',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
