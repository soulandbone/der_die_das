import 'package:der_die_das/constants/strings/app_strings.dart';
import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:der_die_das/presentation/widgets/cardQuestion/options_text.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

enum Answers { der, die, das }

class CardQuestion extends StatefulWidget {
  const CardQuestion({required this.question, this.textSize = 18, super.key});
  final String question;
  final double textSize;

  @override
  State<CardQuestion> createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestion> {
  var answer =
      Answers
          .der; //defaults to der, then its updated by different values of radioButtons. It resolves to an enum

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(45),
      ),
      child: RadioGroup(
        groupValue: answer,
        onChanged: (var value) {
          setState(() {
            answer = value!;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Gap(20),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final currentState = (state as Settings);
                if (currentState.showsArticle) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$answer ${widget.question}',
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                } else if (!currentState.showsArticle) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '___ ${widget.question}',
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
                OptionsText(
                  text: AppStrings.derText,
                  textSize: widget.textSize,
                ),
                Radio(value: Answers.der),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionsText(
                  text: AppStrings.dieText,
                  textSize: widget.textSize,
                ),
                Radio(value: Answers.die),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionsText(
                  text: AppStrings.dasText,
                  textSize: widget.textSize,
                ),
                Radio(value: Answers.das),
              ],
            ),
            Gap(18),

            ElevatedButton(
              onPressed: () {
                context.read<QuestionBloc>().add(
                  AnswerConfirmed(answer: (answer.name).capitalize),
                );
              },
              child: Text(
                'Answer',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
