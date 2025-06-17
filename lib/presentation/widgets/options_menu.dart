import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/optionMenuItem/option_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> texts = [
  'Normal 10',
  "Normal 20",
  'Normal 30',
  'Timed 0:30',
  'Timed 1:00',
  'Timed 2:00',
];
const List<Color> colors = [
  Colors.blue,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.amber,
  Colors.amberAccent,
  Colors.orangeAccent,
];

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final quizBloc = context.read<QuestionBloc>();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return OptionMenuItem(
          index: index,
          text: texts[index],
          color: colors[index],
        );
      },
    );
  }
}
